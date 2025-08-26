import 'package:mimine/common/enums/environment_type.dart';
import 'package:mimine/core/configs/env_config.dart';

class AppConfig {
  final EnvConfig envConfig;
  final Duration apiTimeout;
  final int maxRetryAttempts;
  final Duration retryDelay;

  const AppConfig._({
    required this.envConfig,
    this.apiTimeout = const Duration(seconds: 60),
    this.maxRetryAttempts = 5,
    this.retryDelay = const Duration(seconds: 1),
  });

  static AppConfig load(EnvConfig envConfig) {
    switch (envConfig.environment) {
      case Environment.prod:
        return AppConfig._(
          envConfig: envConfig,
          apiTimeout: const Duration(seconds: 15),
          maxRetryAttempts: 2,
          retryDelay: const Duration(seconds: 1),
        );
      case Environment.staging:
        return AppConfig._(
          envConfig: envConfig,
          apiTimeout: const Duration(seconds: 60),
          maxRetryAttempts: 5,
          retryDelay: const Duration(seconds: 1),
        );
      case Environment.dev:
        return AppConfig._(
          envConfig: envConfig,
          apiTimeout: const Duration(seconds: 60),
          maxRetryAttempts: 5,
          retryDelay: const Duration(seconds: 1),
        );
    }
  }

  @override
  String toString() {
    return 'AppConfig(environment: ${envConfig.environment}, apiTimeout: $apiTimeout)';
  }
}
