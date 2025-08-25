import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiConfig {
  static void configure() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}
}