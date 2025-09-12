import 'dart:async';
import 'package:flutter/foundation.dart';

class DebounceUtil {
  final Duration duration;
  Timer? _timer;

  DebounceUtil({this.duration = const Duration(milliseconds: 300)});

  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  void callAsync(Future<void> Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, () {
      callback();
    });
  }

  void cancel() {
    _timer?.cancel();
  }

  bool get isActive => _timer?.isActive ?? false;

  void dispose() {
    _timer?.cancel();
  }
}
