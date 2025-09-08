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

  // My Info
  static const myInfo = '/user/myInfo';

  // Ad Info
  static const adInfo = '/ad/info';

  // Notification Info
  static const notification = '/notification/info';
  static const notificationRead = '/notification/read';
  static const notificationAllRead = '/notification/allRead';

  // Post
  static const createPost = '/home/createPost';
  static const getPost = '/home/getPost';
  static const updatePost = '/home/updatePost';
  static const deletePost = '/home/deletePost';
  static const likePost = '/home/likePost';
  static const commentPost = '/home/commentPost';
  static const shareCount = '/home/shareCount';
}
