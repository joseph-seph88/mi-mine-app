import 'package:catching_josh/catching_josh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mimine/core/configs/system_ui_config.dart';
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

    // final prefs = await SharedPreferences.getInstance();
    // getIt.registerSingleton<SharedPreferences>(prefs);
    // await MobileAds.instance.initialize();
    // await _initNaverMap();
  }

  static void _initSyncServices() {
    SystemUiConfig.configure();
    setupLocator();
  }
}
