import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const CustomMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}

class CustomMenuWidget {
  static PopupMenuItem<String> customPopupMenuItem(CustomMenuItem item) {
    return PopupMenuItem<String>(
      value: item.title,
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.color.withAlpha(25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.blackF14W700H12.copyWith(
                      color: item.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(item.subtitle, style: AppTextStyles.greyWA204F12W400H13),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.grey.withAlpha(128),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  static List<CustomMenuItem> editDeleteMenuItems(
    BuildContext context,
    VoidCallback editOnTap,
    VoidCallback deleteOnTap,
  ) {
    return [
      CustomMenuItem(
        icon: Icons.edit_rounded,
        title: '수정',
        subtitle: '게시물을 수정합니다',
        color: AppColors.primary,
        onTap: editOnTap,
      ),
      CustomMenuItem(
        icon: Icons.delete_rounded,
        title: '삭제',
        subtitle: '게시물을 삭제합니다',
        color: AppColors.red,
        onTap: deleteOnTap,
      ),
    ];
  }
}

// class CustomMenuWidget {
//   static void showCustomMenu({
//     required BuildContext context,
//     required GlobalKey buttonKey,
//     required List<CustomMenuItem> menuItems,
//     RelativeRect? position,
//   }) {
//     final RenderBox? button =
//         buttonKey.currentContext?.findRenderObject() as RenderBox?;
//     if (button == null) return;

//     final RenderBox overlay =
//         Overlay.of(context).context.findRenderObject() as RenderBox;

//     final RelativeRect menuPosition =
//         position ??
//         RelativeRect.fromRect(
//           Rect.fromPoints(
//             button.localToGlobal(
//               button.size.topRight(Offset.zero),
//               ancestor: overlay,
//             ),
//             button.localToGlobal(
//               button.size.bottomRight(Offset.zero),
//               ancestor: overlay,
//             ),
//           ),
//           Offset.zero & overlay.size,
//         );

//     showMenu<String>(
//       context: context,
//       position: menuPosition,
//       items: menuItems.map((item) => _buildMenuItem(item)).toList(),
//     );
//   }

//   static PopupMenuItem<String> _buildMenuItem(CustomMenuItem item) {
//     return PopupMenuItem<String>(
//       value: item.title,
//       onTap: item.onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: item.color.withAlpha(25),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(item.icon, color: item.color, size: 22),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.title,
//                     style: AppTextStyles.blackF14W700H12.copyWith(
//                       color: item.color,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(item.subtitle, style: AppTextStyles.greyWA204F12W400H13),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.grey.withAlpha(128),
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomMenuButton extends StatelessWidget {
//   final GlobalKey buttonKey;
//   final List<CustomMenuItem> menuItems;
//   final Widget child;
//   final RelativeRect? position;

//   const CustomMenuButton({
//     super.key,
//     required this.buttonKey,
//     required this.menuItems,
//     required this.child,
//     this.position,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => CustomMenuWidget.showCustomMenu(
//         context: context,
//         buttonKey: buttonKey,
//         menuItems: menuItems,
//         position: position,
//       ),
//       child: child,
//     );
//   }
// }
