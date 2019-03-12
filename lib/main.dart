import 'package:flutter/material.dart';
import 'pages/TransitionPage.dart';

void main() => runApp(MyMessageServerApp());
// StatelessWidget 表示一个无状态的组件
// StatefulWidget 表示一个无状态的组件  类比成react的state机制

// 程序的入口
class MyMessageServerApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToYou',
      theme: ThemeData(),
      home: TransitionPage(),
    );
  }
}
