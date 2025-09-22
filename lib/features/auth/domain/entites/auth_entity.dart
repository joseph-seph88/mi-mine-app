import 'package:catching_josh/catching_josh.dart';

class AuthEntity {
  final String id;
  final String nickname;
  final String email;
  final String? errorMessage;
  final bool isSuccess;

  AuthEntity({
    required this.id,
    required this.nickname,
    required this.email,
    this.errorMessage,
    this.isSuccess = false,
  });

  factory AuthEntity.fromJson(StandardResponse response) {
    return AuthEntity(
      id: response.data?['id'] ?? '',
      nickname: response.data?['nickname'] ?? '',
      email: response.data?['email'] ?? '',
      errorMessage: response.statusMessage,
      isSuccess: response.isSuccess ?? false,
    );
  }

  @override
  String toString() {
    return 'AuthEntity(id: $id, nickname: $nickname, email: $email, errorMessage: $errorMessage, isSuccess: $isSuccess)';
  }
}
