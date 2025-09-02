import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/styles/app_colors.dart';

class ShellPage extends StatelessWidget {
  final Widget child;

  const ShellPage({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    final isMapPage = currentIndex == 1;

    return Scaffold(
      backgroundColor: isMapPage ? Colors.transparent : null,
      body: isMapPage ? child : SafeArea(child: child),
      bottomNavigationBar: _buildBottomNavigationBar(context, currentIndex),
    );
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
