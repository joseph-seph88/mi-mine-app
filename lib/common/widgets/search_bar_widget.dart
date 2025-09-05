import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/widgets/app_logo.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool isReadOnly;
  final bool showLogo;

  const SearchBarWidget({
    super.key,
    this.hintText = "",
    this.onSubmitted,
    this.onTap,
    this.controller,
    this.isReadOnly = false,
    this.showLogo = true,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.grey.withAlpha(51),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            onTap: widget.isReadOnly ? () => _onTap() : null,
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: AppColors.grey.withAlpha(160), fontSize: 18),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                prefixIcon: widget.showLogo
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8, right: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SmallLogoWidget(
                              size: 40,
                              text: "MIMINE-JOSEPH",
                              backgroundColor: AppColors.primary,
                              iconColor: AppColors.primary,
                              iconSize: 20,
                              borderColor: AppColors.primary,
                              textColor: AppColors.primary,
                              fontSize: 8,
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.search,
                              color: AppColors.grey.withAlpha(178),
                              size: 24,
                            ),
                          ],
                        ))
                    : Icon(
                        Icons.search,
                        color: AppColors.grey.withAlpha(178),
                        size: 24,
                      ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 90, minHeight: 0),
                suffixIcon: _hasText
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButton(
                            onPressed: _onClear,
                            icon: Icon(Icons.clear,
                                color: AppColors.grey.withAlpha(178), size: 20),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32)))
                    : null,
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                fillColor: Colors.transparent),
            style: const TextStyle(fontSize: 16, color: AppColors.black87),
            onSubmitted: (_) => _onSubmitted(),
            textInputAction: TextInputAction.search,
          )),
        ],
      ),
    );
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _onClear() {
    _controller.clear();
    setState(() {
      _hasText = false;
    });
  }

  void _onSubmitted() {
    widget.onSubmitted?.call(_controller.text);
  }

  void _onTap() {
    widget.onTap?.call();
  }
}
