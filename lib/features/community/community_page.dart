import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // 상단 그라데이션 배경
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary.withOpacity(0.95),
                  secondary.withOpacity(0.85),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // 헤더
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildLogo(),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // 새 게시글 작성
                        },
                        icon: Icon(Icons.edit_note, color: onPrimary, size: 28),
                      ),
                    ],
                  ),
                ),

                // 게시글 목록
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: 15, // 임시 데이터
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 사용자 정보
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.primaries[
                                        index % Colors.primaries.length],
                                    child: Text(
                                      '${(index + 1) % 10}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '사용자${index + 1}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${index + 1}시간 전',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton(
                                    icon: Icon(Icons.more_vert,
                                        color: Colors.grey[600]),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit, size: 20),
                                            SizedBox(width: 8),
                                            Text('수정'),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete,
                                                size: 20, color: Colors.red),
                                            SizedBox(width: 8),
                                            Text('삭제',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 게시글 내용
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                '안녕하세요! 커뮤니티 게시글 ${index + 1}입니다. 오늘 날씨가 정말 좋네요. 여러분은 어떤 하루를 보내고 계신가요? 함께 이야기해보아요! 😊',
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // 이미지 (랜덤하게 표시)
                            if (index % 3 != 0) // 2/3 확률로 이미지 표시
                              Container(
                                height: 200,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),

                            const SizedBox(height: 16),

                            // 해시태그
                            if (index % 2 == 0) // 1/2 확률로 해시태그 표시
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Wrap(
                                  spacing: 8,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '#커뮤니티',
                                        style: TextStyle(
                                          color: Colors.blue[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '#일상',
                                        style: TextStyle(
                                          color: Colors.green[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 16),

                            // 액션 버튼들
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  // 좋아요
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.thumb_up_outlined,
                                          color: Colors.grey[600],
                                          size: 24,
                                        ),
                                      ),
                                      Text(
                                        '${(index + 1) * 5}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(width: 16),

                                  // 댓글
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.comment_outlined,
                                          color: Colors.grey[600],
                                          size: 24,
                                        ),
                                      ),
                                      Text(
                                        '${(index + 1) * 3}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(width: 16),

                                  // 공유
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share_outlined,
                                      color: Colors.grey[600],
                                      size: 24,
                                    ),
                                  ),

                                  const Spacer(),

                                  // 북마크
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.grey[600],
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 새 게시글 작성 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 새 게시글 작성 페이지로 이동
        },
        backgroundColor: primary,
        child: const Icon(Icons.post_add, color: Colors.white),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.pets,
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          const Text(
            "MIMINE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black54,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
