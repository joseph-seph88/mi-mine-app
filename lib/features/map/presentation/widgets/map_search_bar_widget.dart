import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';

class MapSearchBarWidget extends StatefulWidget {
  final String hintText;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final Function()? onFilterTap;
  final TextEditingController? controller;
  final bool isReadOnly;
  final bool showFilter;
  final int filterCount;

  const MapSearchBarWidget({
    super.key,
    this.hintText = "",
    this.onSubmitted,
    this.onTap,
    this.onFilterTap,
    this.controller,
    this.isReadOnly = false,
    this.showFilter = true,
    this.filterCount = 0,
  });

  @override
  State<MapSearchBarWidget> createState() => _MapSearchBarWidgetState();
}

class _MapSearchBarWidgetState extends State<MapSearchBarWidget>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  bool _hasText = false;
  bool _isFocused = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: _isFocused
                    ? AppColors.primary.withAlpha(102)
                    : AppColors.grey.withAlpha(38),
                width: _isFocused ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isFocused
                      ? AppColors.primary.withAlpha(20)
                      : AppColors.black.withAlpha(8),
                  blurRadius: _isFocused ? 16 : 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(26),
                onTap: widget.isReadOnly ? () => _onTap() : null,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.showFilter) ...[
                        GestureDetector(
                          onTap: widget.onFilterTap,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: widget.filterCount > 0
                                  ? AppColors.primary.withAlpha(26)
                                  : AppColors.grey.withAlpha(20),
                              borderRadius: BorderRadius.circular(20),
                              border: widget.filterCount > 0
                                  ? Border.all(
                                      color: AppColors.primary.withAlpha(77),
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.tune_rounded,
                                    color: AppColors.black87,
                                    size: 24,
                                  ),
                                ),
                                if (widget.filterCount > 0)
                                  Positioned(
                                    right: 4,
                                    top: 4,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.filterCount > 9
                                              ? '9+'
                                              : widget.filterCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onTap: widget.isReadOnly ? () => _onTap() : _onFocus,
                          onChanged: (_) => _onFocus(),
                          readOnly: widget.isReadOnly,
                          decoration: InputDecoration(
                            hintText: widget.hintText.isEmpty
                                ? "장소를 검색하세요"
                                : widget.hintText,
                            hintStyle: TextStyle(
                              color: AppColors.grey.withAlpha(128),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: AppColors.grey,
                              size: 22,
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 0,
                            ),
                            suffixIcon: _hasText
                                ? Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(14),
                                        onTap: _onClear,
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: AppColors.grey.withAlpha(20),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: AppColors.black87,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                            suffixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            fillColor: Colors.transparent,
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          onSubmitted: (_) => _onSubmitted(),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _onFocus() {
    if (!_isFocused) {
      setState(() {
        _isFocused = true;
      });
      _animationController.forward();
    }
  }

  void _onClear() {
    _controller.clear();
    setState(() {
      _hasText = false;
    });
  }

  void _onSubmitted() {
    widget.onSubmitted?.call(_controller.text);
    _onUnfocus();
  }

  void _onTap() {
    widget.onTap?.call();
  }

  void _onUnfocus() {
    if (_isFocused) {
      setState(() {
        _isFocused = false;
      });
      _animationController.reverse();
    }
  }
}
