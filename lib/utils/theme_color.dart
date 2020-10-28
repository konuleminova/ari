import 'package:flutter/material.dart';

class ThemeColor {
  static final ThemeColor _instance = ThemeColor._internal();

  factory ThemeColor() {
    return _instance;
  }

  ThemeColor._internal();

  Color yellowColor = Color(0xfffccd13);
  Color greenColor = Color(0xFF5fb640);
}
