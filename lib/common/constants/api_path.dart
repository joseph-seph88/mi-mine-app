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
}
