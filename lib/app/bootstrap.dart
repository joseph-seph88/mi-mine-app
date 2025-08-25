import 'package:catching_josh/catching_josh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mimine/core/configs/system_ui_config.dart';

class Bootstrap {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await joshAsync(() => _initAsyncServices(),
        messageTitle: 'Initializing Async Services');
    joshSync(() => _initSyncServices(),
        messageTitle: 'Initializing Sync Services');
  }

  static Future<void> _initAsyncServices() async {
    await dotenv.load(fileName: '.env');
    // final prefs = await SharedPreferences.getInstance();
    // await LocalDatabase.init();
  }

  static void _initSyncServices() {
    SystemUiConfig.configure();
    // setupLocator();
  }
}
