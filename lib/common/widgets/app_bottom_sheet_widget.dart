import 'package:flutter/material.dart';

class AppBottomSheetWidget extends StatefulWidget {
  final List<String> selectedFilters;
  final Function(List<String>) onFiltersChanged;
  final VoidCallback onApply;
  final VoidCallback onReset;

  const AppBottomSheetWidget({
    super.key,
    required this.selectedFilters,
    required this.onFiltersChanged,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<AppBottomSheetWidget> createState() => _AppBottomSheetWidgetState();
}

class _AppBottomSheetWidgetState extends State<AppBottomSheetWidget> {
  late List<String> _selectedFilters;

  final List<Map<String, dynamic>> _filterCategories = [
    {'name': '맛집', 'icon': Icons.restaurant, 'color': 0xFFFF6B6B},
    {'name': '여행지', 'icon': Icons.landscape, 'color': 0xFF4ECDC4},
    {'name': '쇼핑', 'icon': Icons.shopping_bag, 'color': 0xFFFFE66D},
    {'name': '엔터테인먼트', 'icon': Icons.movie, 'color': 0xFFA8E6CF},
    {'name': '운동/건강', 'icon': Icons.fitness_center, 'color': 0xFF88D8C0},
    {'name': '카페', 'icon': Icons.local_cafe, 'color': 0xFFD4A5A5},
    {'name': '문화/예술', 'icon': Icons.palette, 'color': 0xFFB19CD9},
    {'name': '숙박', 'icon': Icons.hotel, 'color': 0xFF87CEEB},
    {'name': '교통', 'icon': Icons.directions_car, 'color': 0xFF98D8E8},
    {'name': '의료', 'icon': Icons.local_hospital, 'color': 0xFFFFB3BA},
    {'name': '교육', 'icon': Icons.school, 'color': 0xFFFFD93D},
    {'name': '금융', 'icon': Icons.account_balance, 'color': 0xFFB4A7D6},
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilters = List.from(widget.selectedFilters);
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
    widget.onFiltersChanged(_selectedFilters);
  }

  void _resetFilters() {
    setState(() {
      _selectedFilters.clear();
    });
    widget.onFiltersChanged(_selectedFilters);
    widget.onReset();
  }

  void _applyFilters() {
    widget.onApply();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - safeAreaBottom - 24; // 24픽셀 여백 추가

    return Container(
      height: availableHeight * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(),
          _buildFilterContent(),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            const Color(0xFFFAFAFA),
          ],
        ),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '필터',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          Row(
            children: [
              if (_selectedFilters.isNotEmpty) ...[
                GestureDetector(
                  onTap: _resetFilters,
                  child: Text(
                    '초기화',
                    style: TextStyle(
                      color: const Color(0xFF666666),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _selectedFilters.isNotEmpty
                      ? const Color(0xFF007AFF)
                      : const Color(0xFFF1F3F4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _selectedFilters.isNotEmpty
                      ? '${_selectedFilters.length}개 선택'
                      : '선택 안함',
                  style: TextStyle(
                    color: _selectedFilters.isNotEmpty
                        ? Colors.white
                        : const Color(0xFF666666),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterContent() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카테고리 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 카테고리 그리드
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filterCategories.length,
              itemBuilder: (context, index) {
                final category = _filterCategories[index];
                return _buildCategoryCard(category);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    final categoryName = category['name'] as String;
    final icon = category['icon'] as IconData;
    final color = Color(category['color'] as int);
    final isSelected = _selectedFilters.contains(categoryName);

    return GestureDetector(
      onTap: () => _toggleFilter(categoryName),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? color : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFE9ECEF),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              categoryName,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF495057),
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: -0.1,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + safeAreaBottom + 24, // 안전 영역 + 24픽셀 여백
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFF0F0F0), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetFilters,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '초기화',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF007AFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                '필터 적용',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
