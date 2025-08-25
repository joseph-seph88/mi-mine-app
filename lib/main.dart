import 'package:flutter/material.dart';
import 'package:mimine/app/app.dart';
import 'package:mimine/app/bootstrap.dart';

void main() async {
  await Bootstrap.init();
  runApp(const MyApp());
}
