import 'package:catching_josh/catching_josh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mimine/core/infrastructure/config/system_ui_config.dart';
import 'package:mimine/core/core_di/core_locator.dart';
import 'package:rive/rive.dart';

class Bootstrap {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await joshAsync(() => _initAsyncServices());
    joshSync(() => _initSyncServices());
  }

  static Future<void> _initAsyncServices() async {
    await dotenv.load(fileName: '.env');
    await RiveFile.initialize();
    await setupLocator();

    // await MobileAds.instance.initialize();
    await _initNaverMap();
  }

  static void _initSyncServices() {
    SystemUiConfig.configure();
  }

  static Future<void> _initNaverMap() async {
    await FlutterNaverMap().init(
        clientId: dotenv.env['NAVER_MAP_CLIENT_ID'] ?? '',
        onAuthFailed: (ex) {
          switch (ex) {
            case NQuotaExceededException(:final message):
            JoshLogger.singleLogLine("Map 사용량 초과 :: $message");
              break;
            case NUnauthorizedClientException() ||
                  NClientUnspecifiedException() ||
                  NAnotherAuthFailedException():
              JoshLogger.singleLogLine("Map 인증 실패 :: $ex");
              break;
          }
        });
  }
}
