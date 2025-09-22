
import 'package:flutter/material.dart';

class ActivityItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  ActivityItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}