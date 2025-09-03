import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/features/home/presentation/widgets/auto_sliding_ad_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeaderSection()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const AutoSlidingAdSection(),
            ),
          ),
          SliverToBoxAdapter(child: _buildMainContentSection()),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(32),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primary.withAlpha(89),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MIMINE JOSEPH',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '오늘의 순간을 공유해보세요',
                  style: TextStyle(
                    color: AppColors.primary.withAlpha(217),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.create_outlined, color: AppColors.primary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: AppColors.primary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContentSection() {
    return ListView.builder(
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(4),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.lightGrey,
                      child: Icon(Icons.person, color: AppColors.grey),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '사용자 ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${index + 1}시간 전',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '게시물 내용 ${index + 1}입니다. 이것은 샘플 텍스트입니다.',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 160,
                    color: AppColors.lightGrey,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 44,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          color: AppColors.grey,
                        )),
                    const SizedBox(width: 12),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: AppColors.grey,
                        )),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_outlined,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final PageController _pageController;
//   double _currentPage = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(viewportFraction: 0.86);
//     _pageController.addListener(() {
//       setState(() {
//         _currentPage = _pageController.page ?? 0.0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: AppColors.primary,
//         child: const Icon(Icons.edit),
//       ),
//       body: Stack(
//         children: [
//           // 상단 그라데이션 배경
//           Container(
//             height: 260,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   AppColors.primary.withOpacity(0.95),
//                   AppColors.secondary.withOpacity(0.85),
//                 ],
//               ),
//             ),
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 8),
//                     // 헤더
//                     Row(
//                       children: [
//                         // _buildLogo(),
//                         const Spacer(),
//                         IconButton(
//                           onPressed: () {},
//                           icon:
//                               Icon(Icons.notifications_none, color: AppColors.primary),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.settings_outlined, color: AppColors.primary),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),

//                     // 히어로 섹션
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(16),
//                         border:
//                             Border.all(color: Colors.white.withOpacity(0.2)),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 26,
//                             backgroundColor: Colors.white.withOpacity(0.35),
//                             child:
//                                 const Icon(Icons.person, color: Colors.white),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '어서오세요',
//                                   style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 Text(
//                                   '오늘의 순간을 공유해보세요',
//                                   style: TextStyle(
//                                     color: AppColors.primary.withOpacity(0.85),
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           TextButton.icon(
//                             onPressed: () {},
//                             style: TextButton.styleFrom(
//                               foregroundColor: AppColors.primary,
//                               backgroundColor: Colors.white.withOpacity(0.18),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 8),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                             ),
//                             icon: const Icon(Icons.add, size: 18),
//                             label: const Text('새 글'),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 18),

//                     // 피처드 캐러셀
//                     SizedBox(
//                       height: 220,
//                       child: PageView.builder(
//                         controller: _pageController,
//                         itemCount: 5,
//                         itemBuilder: (context, index) {
//                           final double delta = (_currentPage - index).abs();
//                           final double scale =
//                               1.0 - (delta * 0.08).clamp(0.0, 0.08);
//                           final double translate =
//                               (delta * 10).clamp(0.0, 10.0);
//                           return Transform.translate(
//                             offset: Offset(0, translate),
//                             child: AnimatedScale(
//                               duration: const Duration(milliseconds: 240),
//                               scale: scale,
//                               child: Container(
//                                 margin: const EdgeInsets.only(right: 12),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(18),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors: [
//                                       Colors.white,
//                                       Colors.white.withOpacity(0.85),
//                                     ],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.08),
//                                       blurRadius: 16,
//                                       offset: const Offset(0, 8),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(18),
//                                   child: Stack(
//                                     fit: StackFit.expand,
//                                     children: [
//                                       Container(color: Colors.grey[200]),
//                                       Align(
//                                         alignment: Alignment.bottomLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 '추천 ${index + 1}',
//                                                 style: const TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w700,
//                                                   color: Colors.black87,
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 4),
//                                               Text(
//                                                 '지금 인기 있는 콘텐츠를 확인해보세요',
//                                                 style: TextStyle(
//                                                   fontSize: 13,
//                                                   color: Colors.black
//                                                       .withOpacity(0.6),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 10),
//                     // 인디케이터
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(5, (i) {
//                         final bool active = (_currentPage.round() == i);
//                         return AnimatedContainer(
//                           duration: const Duration(milliseconds: 240),
//                           width: active ? 20 : 8,
//                           height: 8,
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           decoration: BoxDecoration(
//                             color: active
//                                 ? AppColors.    primary
//                                 : Colors.white.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         );
//                       }),
//                     ),

//                     const SizedBox(height: 18),

//                     // 게시물 섹션 타이틀
//                     Row(
//                       children: const [
//                         Text(
//                           '게시물',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black87,
//                             letterSpacing: -0.2,
//                           ),
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                     const SizedBox(height: 12),

//                     // 게시물 목록
//                     ListView.builder(
//                       itemCount: 10,
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.04),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 6),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 22,
//                                       backgroundColor: Colors.grey[300],
//                                       child: Icon(Icons.person,
//                                           color: Colors.grey[700]),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '사용자 ${index + 1}',
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           Text(
//                                             '${index + 1}시간 전',
//                                             style: TextStyle(
//                                               color: Colors.grey[600],
//                                               fontSize: 13,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {},
//                                       icon: const Icon(Icons.more_horiz),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   '게시물 내용 ${index + 1}입니다. 이것은 샘플 텍스트입니다.',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     height: 1.45,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Container(
//                                     height: 160,
//                                     color: Colors.grey[200],
//                                     child: Center(
//                                       child: Icon(
//                                         Icons.image,
//                                         size: 44,
//                                         color: Colors.grey[500],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.favorite_border,
//                                         color: Colors.grey[700]),
//                                     const SizedBox(width: 12),
//                                     Icon(Icons.chat_bubble_outline,
//                                         color: Colors.grey[700]),
//                                     const SizedBox(width: 12),
//                                     Icon(Icons.share_outlined,
//                                         color: Colors.grey[700]),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white.withOpacity(0.2),
//         border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(
//             Icons.pets,
//             size: 24,
//             color: Colors.white,
//           ),
//           const SizedBox(width: 8),
//           const Text(
//             "MIMINE",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 3,
//               shadows: [
//                 Shadow(
//                   blurRadius: 2.0,
//                   color: Colors.black54,
//                   offset: Offset(1.0, 1.0),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
