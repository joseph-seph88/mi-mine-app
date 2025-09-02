abstract class AppError {
  final String message;
  AppError(this.message);
}

class UnknownError extends AppError {
  final int? statusCode;
  UnknownError({required String message, this.statusCode}) : super(message);
}

class HttpError extends AppError {
  final int statusCode;
  HttpError({required String message, required this.statusCode})
      : super(message);
}

class TokenError extends AppError {
  TokenError(super.message);
}

class NullError extends AppError {
  NullError(super.message);
}

class LogoutError extends AppError {
  LogoutError(super.message);
}

class LocationError extends AppError {
  LocationError(super.message);
}

class StorageError extends AppError {
  StorageError(super.message);
}

class PermissionError extends AppError {
  PermissionError(super.message);
}
