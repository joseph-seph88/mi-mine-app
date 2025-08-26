import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mimine/common/enums/environment_type.dart';

class EnvConfig {
  final String serverUrl;
  final String authTokenKey;
  final String refreshTokenKey;
  final String appName;
  final String appVersion;
  final Environment environment;

  const EnvConfig._({
    required this.serverUrl,
    required this.authTokenKey,
    required this.refreshTokenKey,
    required this.appName,
    required this.appVersion,
    required this.environment,
  });

  static EnvConfig load() {
    return EnvConfig._(
      serverUrl: _getServerUrl(),
      authTokenKey: dotenv.env['ACCESS_TOKEN_KEY'] ?? 'access_token',
      refreshTokenKey: dotenv.env['REFRESH_TOKEN_KEY'] ?? 'refresh_token',
      appName: dotenv.env['APP_NAME'] ?? 'MIMINE',
      appVersion: dotenv.env['APP_VERSION'] ?? '1.0.00',
      environment: _getEnvironment(),
    );
  }

  static String _getServerUrl() {
    const environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');

    switch (environment) {
      case 'prod':
        return dotenv.env['PROD_URL'] ?? 'http://prod-api.mimine.com';
      case 'staging':
        return dotenv.env['STAGE_URL'] ?? 'http://stage-api.mimine.com';
      case 'dev':
      default:
        return dotenv.env['DEV_URL'] ?? 'http://dev-api.mimine.com';
    }
  }

  static Environment _getEnvironment() {
    const environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');

    switch (environment) {
      case 'prod':
        return Environment.prod;
      case 'staging':
        return Environment.staging;
      case 'dev':
      default:
        return Environment.dev;
    }
  }

  bool get isDevelopment => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.prod;

  @override
  String toString() {
    return 'EnvConfig(serverUrl: $serverUrl, environment: $environment, appName: $appName)';
  }
}
