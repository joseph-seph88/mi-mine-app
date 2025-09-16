abstract class MyInfoMock {
  static Map<String, dynamic> get myInfoJson => {
    'id': 'user_12345',
    'nickname': 'Joseph88',
    'email': 'joseph88@example.com',
    'motto': 'THIS MOMENT',
    'todayThought': '내일은 존재하지 않는다. 오늘만이 존재할뿐이다.',
    'contentsCount': 12,
    'profileImage': null,
    'accessToken': 'mock_access_token_12345',
    'refreshToken': 'mock_refresh_token_67890',
    'friends': [
      {'id': 'user_22222', 'nickname': '이영희', 'email': 'leeyh@example.com'},
      {'id': 'user_33333', 'nickname': '박민수', 'email': 'parkms@example.com'},
      {'id': 'user_44444', 'nickname': '이지은', 'email': 'lejieun@example.com'},
    ],
    'followers': [
      {'id': 'user_55555', 'nickname': '김영희', 'email': 'kimyeongh@example.com'},
      {'id': 'user_66666', 'nickname': '이영희', 'email': 'leeyh@example.com'},
    ],
  };
}
