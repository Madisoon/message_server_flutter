import 'package:flutter/material.dart';

/// 主题颜色的静态变量
class ThemeConstant {
  /// 可选的主题色
  static List<Color> supportColors = [
    Color(0xFF7a77bd),
    Color(0xFFf8f6f2),
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
  ];

  static List<Map> supportColor = [
    {
      'name': '',
      'primaryColor': Color(0xFF7a77bd),
      'accentColor': Color(0xFF5fc2ed),
    },
    {
      'name': '',
      'primaryColor': Color(0xFF7a77bd),
      'accentColor': Color(0xFF5fc2ed),
    },
    {
      'name': '',
      'primaryColor': Color(0xFF7a77bd),
      'accentColor': Color(0xFF5fc2ed),
    },
  ];

  // 当前的主题色
  static Color currentColorTheme = supportColors[0];
}
