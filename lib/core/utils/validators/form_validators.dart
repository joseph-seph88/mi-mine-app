abstract class FormValidators {
  static final _emailRegExp =
      RegExp(r'^[a-zA-Z0-9]{2,}@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');
  static final _passwordRegExp =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
  static final _nameRegExp = RegExp(r'^[가-힣a-zA-Z]+$');

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    if (!_emailRegExp.hasMatch(value)) {
      return '유효한 이메일을 입력해주세요';
    }
    if (value.length > 128) {
      return '이메일은 128자 이하로 입력해주세요';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    if (value.length < 8) {
      return '비밀번호는 8자 이상이어야 합니다';
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return '비밀번호는 영문, 숫자 특수문자 3개 이상으로 조합하여야합니다';
    }
    return null;
  }

  static String? confirmPassword(String previousValue, String currentValue) {
    if (currentValue.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    if (currentValue.length < 8) {
      return '비밀번호는 최소 8자 이상이어야 합니다';
    }
    if (!_passwordRegExp.hasMatch(currentValue)) {
      return '비밀번호는 영문, 숫자 특수문자 3개 이상으로 조합하여야합니다';
    }
    if (previousValue != currentValue) {
      return '비밀번호가 일치하지 않습니다';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요';
    }
    if (!_nameRegExp.hasMatch(value)) {
      return '유효한 이름을 입력해주세요';
    }
    if (value.length > 12) {
      return '이름은 12자 이하로 입력해주세요';
    }
    return null;
  }
}
