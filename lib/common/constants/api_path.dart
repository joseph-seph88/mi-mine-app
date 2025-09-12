abstract class ApiPath {
  // Auth
  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const refresh = '/auth/refresh';
  static const sessionCheck = '/auth/check';
  static const sessionInvalidate = '/auth/invalidate';
  static const signUp = '/user/signUp';

  // Map
  static const mapList = '/map/list';
  static const currentLocation = '/map/currentLocation';
  static const placeInfoList = '/map/placeInfoList';

  // My Info
  static const myInfo = '/user/myInfo';

  // Ad Info
  static const adInfo = '/ad/info';

  // Notification Info
  static const notification = '/notification/info';
  static const notificationRead = '/notification/read';
  static const notificationAllRead = '/notification/allRead';

  // Post
  static const post = '/home/post';
  static const myPosts = '/home/post/myPosts';
  static const myBestPosts = '/home/post/myBestPosts';
  static const likePost = '/home/post/like';
  static const commentPost = '/home/post/comment';
  static const shareCount = '/home/post/shareCount';

  // Community
  static const community = '/community';
  static const allPosts = '/community/allPosts';
}
