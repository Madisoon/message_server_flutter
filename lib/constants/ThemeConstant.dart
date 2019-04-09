import 'package:flutter/material.dart';

/// 主题颜色的静态变量
class ThemeConstant {
  /// 默认主题色
  static const Color defaultColor = const Color(0xFF7a77bd);

  /// 可选的主题色
  static List<Color> supportColors = [
    Colors.white,
    defaultColor,
    Colors.white,
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal,
  ];

  // 当前的主题色
  static Color currentColorTheme = defaultColor;
}
