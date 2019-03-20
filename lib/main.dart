import 'package:flutter/material.dart';
import 'pages/TransitionPage.dart';
import 'dart:io';

void main() => runApp(MyMessageServerApp());
// StatelessWidget 表示一个有状态的组件
// StatefulWidget 表示一个无状态的组件  类比成react的state机制

// 程序的入口
class MyMessageServerApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    /// IOS 主题
    ThemeData ios = new ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFF7a77bd),
      accentColor: Color(0xFF5fc2ed),
    );

    /// android 主题
    ThemeData android = new ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFF7a77bd),
      accentColor: Color(0xFF5fc2ed),
    );

    return MaterialApp(
      theme: Platform.isAndroid ? android : ios,
      title: 'ToYou',
      home: TransitionPage(),
    );
  }
}
