import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  List<String> recentSearches = ['교대역', '강남역', '홍대입구'];
  List<String> suggestions = ['지하철역', '대학교', '병원', '은행', '카페', '맛집'];
  List<String> filteredSuggestions = [];
  bool _isSearching = false;

  List<Map<String, dynamic>> getSearchResults(String keyword) {
    final List<Map<String, dynamic>> data = [
      {'title': '서울시 영등포구 교대동', 'subtitle': null, 'type': '지역'},
      {'title': '충남 청양군 교대면', 'subtitle': null, 'type': '지역'},
      {'title': '교대역 3호선', 'subtitle': null, 'type': '지하철'},
      {'title': '교대역 5호선', 'subtitle': null, 'type': '지하철'},
      {'title': '교대 금호어울림', 'subtitle': '서울시 마포구 서교동', 'type': '아파트'},
      {'title': '서교대아파트', 'subtitle': '서울시 마포구 서교동', 'type': '아파트'},
      {'title': '교대역 월드메르디앙', 'subtitle': '서울시 마포구 서교동', 'type': '아파트'},
      {'title': '교대역동서프라임36', 'subtitle': '서울시 마포구 서교동', 'type': '아파트'},
    ];

    if (keyword.isEmpty) return data;

    return data.where((item) {
      final title = item['title'].toString().toLowerCase();
      final subtitle = item['subtitle']?.toString().toLowerCase() ?? '';
      final searchKeyword = keyword.toLowerCase();
      return title.contains(searchKeyword) || subtitle.contains(searchKeyword);
    }).toList();
  }

  Widget _highlightText(String text, String keyword) {
    if (keyword.isEmpty) {
      return Text(
        text,
        style: const TextStyle(
          color: Color(0xFF191919),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      );
    }
    final spans = <TextSpan>[];
    int start = 0;
    final lowerText = text.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    while (true) {
      final index = lowerText.indexOf(lowerKeyword, start);
      if (index < 0) {
        spans.add(
          TextSpan(
            text: text.substring(start),
            style: const TextStyle(
              color: Color(0xFF191919),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
        break;
      }
      if (index > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, index),
            style: const TextStyle(
              color: Color(0xFF191919),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + keyword.length),
          style: const TextStyle(
            color: Color(0xFF00945A),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
      start = index + keyword.length;
    }
    return RichText(text: TextSpan(children: spans));
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filteredSuggestions = suggestions;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        filteredSuggestions = suggestions;
      } else {
        filteredSuggestions = suggestions
            .where((suggestion) => suggestion.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '장소를 검색해보세요',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child:
                _isSearching ? _buildSearchResults() : _buildDefaultContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (recentSearches.isNotEmpty) ...[
            _buildModernSectionHeader('최근 검색어'),
            const SizedBox(height: 16),
            _buildModernChips(
              recentSearches,
              onTap: (search) => _onRecentSearchTap(search),
              showDelete: true,
              onDelete: (search) => _removeRecentSearch(search),
            ),
            const SizedBox(height: 32),
          ],

          // Suggestions
          _buildModernSectionHeader('추천 검색어'),
          const SizedBox(height: 16),
          _buildModernChips(
            suggestions,
            onTap: (suggestion) => _onSuggestionTap(suggestion),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = getSearchResults(_searchController.text);
    return results.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _addToRecentSearches(item['title']);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getTypeColor(item['type']).withAlpha(20),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getTypeIcon(item['type']),
                            color: _getTypeColor(item['type']),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _highlightText(
                                  item['title'], _searchController.text),
                              if (item['subtitle'] != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  item['subtitle'],
                                  style: const TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(item['type']).withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item['type'],
                            style: TextStyle(
                              color: _getTypeColor(item['type']),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case '지하철':
        return const Color(0xFF00945A);
      case '지역':
        return const Color(0xFF2196F3);
      case '아파트':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF666666);
    }
  }

  IconData _getTypeIcon(String? type) {
    switch (type) {
      case '지하철':
        return Icons.train;
      case '지역':
        return Icons.location_on;
      case '아파트':
        return Icons.apartment;
      default:
        return Icons.place;
    }
  }

  void _addToRecentSearches(String search) {
    if (!recentSearches.contains(search)) {
      setState(() {
        recentSearches.insert(0, search);
        if (recentSearches.length > 10) {
          recentSearches.removeLast();
        }
      });
    }
  }

  Widget _buildModernSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildModernChips(
    List<String> items, {
    required Function(String) onTap,
    bool showDelete = false,
    Function(String)? onDelete,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        return _buildModernChip(
          item,
          onTap: () => onTap(item),
          showDelete: showDelete,
          onDelete: onDelete != null ? () => onDelete(item) : null,
        );
      }).toList(),
    );
  }

  Widget _buildModernChip(
    String text, {
    required VoidCallback onTap,
    bool showDelete = false,
    VoidCallback? onDelete,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showDelete && onDelete != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 30,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '검색 결과가 없습니다',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '다른 키워드로 검색해보세요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _onSearch(String query) {
    if (query.trim().isNotEmpty) {
      // Add to recent searches if not already present
      if (!recentSearches.contains(query)) {
        setState(() {
          recentSearches.insert(0, query);
          if (recentSearches.length > 10) {
            recentSearches.removeLast();
          }
        });
      }
    }
  }

  void _onRecentSearchTap(String search) {
    _searchController.text = search;
    _onSearch(search);
  }

  void _onSuggestionTap(String suggestion) {
    _searchController.text = suggestion;
    _onSearch(suggestion);
  }

  void _removeRecentSearch(String search) {
    setState(() {
      recentSearches.remove(search);
    });
  }
}
