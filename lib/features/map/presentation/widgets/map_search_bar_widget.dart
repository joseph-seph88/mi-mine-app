import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';

class MapSearchBarWidget extends StatefulWidget {
  final String hintText;
  final Function()? onTap;
  final Function()? onFilterTap;
  final int filterCount;

  const MapSearchBarWidget({
    super.key,
    this.hintText = "",
    this.onTap,
    this.onFilterTap,
    this.filterCount = 0,
  });

  @override
  State<MapSearchBarWidget> createState() => _MapSearchBarWidgetState();
}

class _MapSearchBarWidgetState extends State<MapSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.grey.withAlpha(38), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildFilterSection(),
            const SizedBox(width: 12),
            Expanded(child: _buildTextFieldSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
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
                ? Border.all(color: AppColors.primary.withAlpha(77), width: 1)
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
    );
  }

  Widget _buildTextFieldSection() {
    return TextField(
      readOnly: true,
      onTap: _onTap,
      decoration: InputDecoration(
        hintText: widget.hintText.isEmpty ? "장소를 검색하세요" : widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.grey.withAlpha(128),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        isDense: true,
        prefixIcon: Icon(Icons.search_rounded, color: AppColors.grey, size: 22),
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
        fillColor: Colors.transparent,
      ),
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _onTap() => widget.onTap?.call();
}
