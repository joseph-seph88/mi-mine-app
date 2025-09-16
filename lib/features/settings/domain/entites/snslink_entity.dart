import 'package:flutter/material.dart';

class SnsLink {
  final String platform;
  final String username;
  final String url;
  final bool isConnected;
  final IconData icon;
  final Color color;

  SnsLink({
    required this.platform,
    required this.username,
    required this.url,
    required this.isConnected,
    required this.icon,
    required this.color,
  });
}
