import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/features/community/presentation/pages/community_page.dart';
import 'package:mimine/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:mimine/features/auth/presentation/pages/login_page.dart';
import 'package:mimine/features/community/presentation/pages/other_user_community_page.dart';
import 'package:mimine/features/post/presentation/pages/create_post_page.dart';
import 'package:mimine/features/post/presentation/pages/edit_post_page.dart';
import 'package:mimine/features/home/presentation/pages/home_page.dart';
import 'package:mimine/features/home/presentation/pages/notification_page.dart';
import 'package:mimine/features/post/presentation/pages/post_detail_page.dart';
import 'package:mimine/features/map/presentation/pages/map_page.dart';
import 'package:mimine/features/map/presentation/pages/search_page.dart';
import 'package:mimine/features/settings/presentation/pages/edit_my_profile.dart';
import 'package:mimine/features/settings/presentation/pages/notification_settings_page.dart';
import 'package:mimine/features/settings/presentation/pages/app_info_page.dart';
import 'package:mimine/features/settings/presentation/pages/privacy_settings_page.dart';
import 'package:mimine/features/settings/presentation/pages/my_activity_page.dart';
import 'package:mimine/features/settings/presentation/pages/contact_page.dart';
import 'package:mimine/features/settings/presentation/pages/sns_links_page.dart';
import 'package:mimine/features/shell/presentation/pages/shell_page.dart';
import 'package:mimine/features/splash/presentation/pages/error_page.dart';
import 'package:mimine/features/settings/presentation/pages/settings_page.dart';
import 'package:mimine/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mimine/features/splash/presentation/pages/splash_page.dart';

final ShellRoute shellRoutes = ShellRoute(
  builder: (context, state, child) => ShellPage(child: child),
  routes: [
    GoRoute(
      path: RouterPath.home,
      name: RouterName.home,
      pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
    ),
    GoRoute(
      path: RouterPath.map,
      name: RouterName.map,
      pageBuilder: (context, state) => NoTransitionPage(child: MapPage()),
    ),
    GoRoute(
      path: RouterPath.community,
      name: RouterName.community,
      pageBuilder: (context, state) => NoTransitionPage(child: CommunityPage()),
    ),
    GoRoute(
      path: RouterPath.settings,
      name: RouterName.settings,
      pageBuilder: (context, state) => NoTransitionPage(child: SettingsPage()),
    ),
  ],
);

final List<RouteBase> routerRoutes = [
  GoRoute(
    path: RouterPath.splash,
    name: RouterName.splash,
    builder: (context, state) => SplashPage(),
  ),
  GoRoute(
    path: RouterPath.error,
    name: RouterName.error,
    builder: (context, state) => ErrorPage(),
  ),
  GoRoute(
    path: RouterPath.login,
    name: RouterName.login,
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: RouterPath.signUp,
    name: RouterName.signUp,
    builder: (context, state) => SignUpPage(),
  ),
  GoRoute(
    path: RouterPath.forgotPassword,
    name: RouterName.forgotPassword,
    builder: (context, state) => ForgotPasswordPage(),
  ),
  GoRoute(
    path: RouterPath.createPost,
    name: RouterName.createPost,
    builder: (context, state) => CreatePostPage(),
  ),
  GoRoute(
    path: RouterPath.notification,
    name: RouterName.notification,
    builder: (context, state) => NotificationPage(),
  ),
  GoRoute(
    path: '${RouterPath.postDetail}/:postId',
    name: RouterName.postDetail,
    builder: (context, state) {
      final postId = state.pathParameters['postId']!;
      final extra = state.extra as Map<String, dynamic>?;

      final post = PostEntity(
        postId: postId,
        title: extra?['title'] ?? '게시물 제목',
        description: extra?['description'] ?? '게시물 설명입니다.',
        imageUrl: extra?['imageUrl'],
      );
      return PostDetailPage(post: post);
    },
  ),

  GoRoute(
    path: RouterPath.editPost,
    name: RouterName.editPost,
    builder: (context, state) {
      final post = state.extra as PostEntity;
      return EditPostPage(post: post);
    },
  ),

  GoRoute(
    path: RouterPath.search,
    name: RouterName.search,
    pageBuilder: (context, state) => NoTransitionPage(child: SearchPage()),
  ),

  GoRoute(
    path: '${RouterPath.otherUserCommunity}/:userId',
    name: RouterName.otherUserCommunity,
    builder: (context, state) {
      final userId = state.pathParameters['userId']!;
      return OtherUserCommunityPage(userId: userId);
    },
  ),

  GoRoute(
    path: RouterPath.editMyProfile,
    name: RouterName.editMyProfile,
    builder: (context, state) => EditMyProfilePage(),
  ),

  GoRoute(
    path: RouterPath.notificationSettings,
    name: RouterName.notificationSettings,
    builder: (context, state) => NotificationSettingsPage(),
  ),

  GoRoute(
    path: RouterPath.appInfo,
    name: RouterName.appInfo,
    builder: (context, state) => AppInfoPage(),
  ),

  GoRoute(
    path: RouterPath.privacySettings,
    name: RouterName.privacySettings,
    builder: (context, state) => PrivacySettingsPage(),
  ),

  GoRoute(
    path: RouterPath.myActivity,
    name: RouterName.myActivity,
    builder: (context, state) => MyActivityPage(),
  ),

  GoRoute(
    path: RouterPath.contact,
    name: RouterName.contact,
    builder: (context, state) => ContactPage(),
  ),

  GoRoute(
    path: RouterPath.snsLinks,
    name: RouterName.snsLinks,
    builder: (context, state) => SnsLinksPage(),
  ),

  shellRoutes,
];
