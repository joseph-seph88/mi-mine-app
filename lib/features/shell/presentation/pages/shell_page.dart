import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/widgets/permission_dialog.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_cubit.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_state.dart';

class ShellPage extends StatefulWidget {
  final Widget child;

  const ShellPage({required this.child, super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await context.read<ShellCubit>().checkRequestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    final isMapPage = currentIndex == 1;

    return BlocListener<ShellCubit, ShellState>(

        listener: (context, state) {
          if (state.permissionStatusType ==
                  PermissionStatusType.permissionPermanentlyDenied ||
              state.permissionStatusType ==
                  PermissionStatusType.permissionDenied) {
            PermissionDialog.show(context, state);
          }
        },
        child: Scaffold(
          backgroundColor: isMapPage ? Colors.transparent : null,
          body: isMapPage ? widget.child : SafeArea(child: widget.child),
          bottomNavigationBar: _buildBottomNavigationBar(context, currentIndex),
        ));
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case RouterPath.home:
        return 0;
      case RouterPath.map:
        return 1;
      case RouterPath.community:
        return 2;
      case RouterPath.profile:
        return 3;
      default:
        return 0;
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            context.goNamed(RouterName.home);
            break;
          case 1:
            context.goNamed(RouterName.map);
            break;
          case 2:
            context.goNamed(RouterName.community);
            break;
          case 3:
            context.goNamed(RouterName.profile);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: '지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.forum),
          label: '게시판',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ],
    );
  }
}
