import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/constants/rive_path.dart';
import 'package:mimine/features/splash/presentation/cubits/splash_cubit.dart';
import 'package:mimine/features/splash/presentation/cubits/splash_state.dart';
import 'package:mimine/features/splash/presentation/enums/splash_status.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'dart:math' as math;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _horizontalController;
  late AnimationController _verticalController;
  late Animation<double> _slide;
  late Animation<double> _horizontalShake;
  late Animation<double> _verticalShake;
  final math.Random _random = math.Random();
  Timer? _verticalTimer;

  double _pageFadeOpacity = 1.0;
  double _loadingFadeOpacity = 1.0;
  double _riveFadeOpacity = 0.0;
  double _textFadeOpacity = 1.0;
  bool _showLoading = true;
  bool _isLoadingEnded = false;
  bool _isNextPage = false;

  @override
  void initState() {
    super.initState();
    _initHorizontalAnimation();
    _initVerticalAnimation();
    _runSplashChecks();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    _verticalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _pageFadeOpacity,
      duration: const Duration(milliseconds: 400),
      onEnd: _pageFadeOnEnded,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state.splashStatus == SplashStatus.success) {
              context.goNamed(RouterName.home);
            }
            if (state.splashStatus == SplashStatus.failure) {
              context.goNamed(RouterName.login);
            }
            if (state.splashStatus == SplashStatus.error) {
              context.goNamed(RouterName.error);
            }
          },
          listenWhen: (previous, current) =>
              previous.splashStatus != current.splashStatus,
          builder: (context, state) {
            if (!state.isLoading && _loadingFadeOpacity != 0.0) {
              _startLoadingFadeOut();
            }

            return Stack(
              children: [
                Positioned.fill(
                    child: AnimatedOpacity(
                        opacity: _riveFadeOpacity,
                        duration: const Duration(milliseconds: 600),
                        onEnd: _riveFadeOnEnded,
                        child: _buildRiveAnimation())),
                if (_showLoading)
                  Positioned.fill(
                      child: AnimatedOpacity(
                          opacity: _loadingFadeOpacity,
                          duration: const Duration(milliseconds: 600),
                          onEnd: _loadingFadeOnEnded,
                          child: _buildLoadingSection())),
                if (_isLoadingEnded) ...[
                  Positioned(
                    top: 290,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                        opacity: _textFadeOpacity,
                        duration: const Duration(milliseconds: 400),
                        onEnd: _textFadeOnEnded,
                        child: AnimatedBuilder(
                            animation: Listenable.merge(
                                [_horizontalController, _verticalController]),
                            builder: (context, child) =>
                                _builTitleTranslation(child),
                            child: _buildTitleSection())),
                  ),
                  Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: AnimatedOpacity(
                          opacity: _textFadeOpacity,
                          duration: const Duration(milliseconds: 400),
                          onEnd: _textFadeOnEnded,
                          child: _buildSlogan())),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Drive machine');
    if (controller != null) {
      artboard.addController(controller);
    }
  }

  void _runSplashChecks() {
    context.read<SplashCubit>().checkSession();
  }

  void _pageFadeOnEnded() {
    final splashStatus = context.read<SplashCubit>().state.splashStatus;
    switch (splashStatus) {
      case SplashStatus.success:
        context.goNamed(RouterName.home);
        break;
      case SplashStatus.failure:
        context.goNamed(RouterName.login);
        break;
      default:
        context.goNamed(RouterName.error);
        break;
    }
  }

  void _riveFadeOnEnded() {
    if (_riveFadeOpacity == 1.0) {
      Future.delayed(const Duration(milliseconds: 1800), () {
        if (mounted) {
          setState(() {
            _riveFadeOpacity = 0.0;
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) {
              setState(() {
                _textFadeOpacity = 0.0;
              });
            }
          });
        }
      });
    }
  }

  void _loadingFadeOnEnded() {
    if (_loadingFadeOpacity == 0.0 && _showLoading) {
      setState(() {
        _showLoading = false;
        _isLoadingEnded = true;
        _riveFadeOpacity = 1.0;
      });
    }
  }

  void _textFadeOnEnded() {
    if (_textFadeOpacity == 0.0) {
      setState(() {
        _pageFadeOpacity = 0.0;
      });
    }
  }

  void _startLoadingFadeOut() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _loadingFadeOpacity = 0.0;
        });
      }
    });
  }

  void _initHorizontalAnimation() {
    _horizontalController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + _random.nextInt(1500)),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          _horizontalController.duration =
              Duration(milliseconds: 1500 + _random.nextInt(1500));
          _horizontalController.reverseDuration =
              _horizontalController.duration;
          _setRandomSlideTween();
          _horizontalController.repeat(reverse: true);
        }
      });
    _setRandomSlideTween();
    _horizontalShake = Tween<double>(begin: -5, end: 5).animate(CurvedAnimation(
        parent: _horizontalController, curve: Curves.elasticInOut));
    _horizontalController.repeat(reverse: true);
  }

  void _initVerticalAnimation() {
    _verticalController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800 + _random.nextInt(700)));
    _verticalShake =
        Tween<double>(begin: 0, end: 0).animate(_verticalController);
    _scheduleNextVerticalShake();
  }

  void _setRandomSlideTween() {
    double minDistance = 0;
    double lastDistance = 0;

    if (lastDistance == 0) {
      minDistance = _random.nextDouble() * 40;
      lastDistance = _random.nextBool() ? minDistance : -minDistance;
    } else {
      lastDistance = -lastDistance;
    }

    double slideStart = 0;
    double slideEnd = lastDistance;
    _slide = Tween<double>(begin: slideStart, end: slideEnd).animate(
      CurvedAnimation(parent: _horizontalController, curve: Curves.easeInOut),
    );
  }

  void _scheduleNextVerticalShake() {
    _verticalTimer?.cancel();
    final nextDelay = Duration(milliseconds: 2000 + _random.nextInt(2000));
    _verticalTimer = Timer(nextDelay, () async {
      final double amplitude = 8 + _random.nextDouble() * 16;
      _verticalController.duration =
          Duration(milliseconds: 800 + _random.nextInt(700));
      _verticalShake = Tween<double>(
              begin: 0, end: amplitude * (_random.nextBool() ? 1 : -1))
          .animate(CurvedAnimation(
              parent: _verticalController, curve: Curves.easeInOut));
      await _verticalController.forward(from: 0);
      _verticalController.duration =
          Duration(milliseconds: 600 + _random.nextInt(400));
      _verticalShake = Tween<double>(begin: _verticalShake.value, end: 0)
          .animate(CurvedAnimation(
              parent: _verticalController, curve: Curves.easeInOut));
      await _verticalController.forward(from: 0);
      _verticalShake =
          Tween<double>(begin: 0, end: 0).animate(_verticalController);
      _scheduleNextVerticalShake();
    });
  }

  Widget _buildLoadingSection() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_takeoff, color: Colors.white, size: 64),
            SizedBox(height: 16),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildRiveAnimation() {
    return RiveAnimation.asset(
      RivePath.drive,
      fit: BoxFit.cover,
      onInit: _onRiveInit,
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.flight_takeoff,
                color: Colors.black45.withAlpha((0.2 * 255).toInt()), size: 56),
            Icon(Icons.flight_takeoff, color: Colors.white, size: 48),
          ],
        ),
        const SizedBox(width: 12),
        Text(
          'JOSEPH88',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [
              Shadow(
                blurRadius: 16,
                color: Colors.indigoAccent.withAlpha((0.5 * 255).toInt()),
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 4,
                color: Colors.black45.withAlpha((0.3 * 255).toInt()),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _builTitleTranslation(Widget? child) {
    return Transform.translate(
      offset:
          Offset(_slide.value + _horizontalShake.value, _verticalShake.value),
      child: child,
    );
  }

  Widget _buildSlogan() {
    return Text(
      'Adventure Awaits!',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w500),
    );
  }
}
