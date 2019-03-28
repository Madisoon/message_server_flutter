import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/TransitionPage.dart';
import 'dart:io';
import './utils/theme_event.dart';
import './constants/ThemeConstant.dart';
import './constants/CommonConstant.dart';

void main() async {
  int themeIndex = await getDefaultTheme();
  runApp(MyMessageServerApp(themeIndex));
}

// StatelessWidget 表示一个有状态的组件
// StatefulWidget 表示一个无状态的组件  类比成react的state机制

Future<int> getDefaultTheme() async {
  // 从shared_preferences中获取上次切换的主题
  SharedPreferences sp = await SharedPreferences.getInstance();
  int themeIndex = sp.getInt("themeIndex");
  if (themeIndex != null) {
    return themeIndex;
  }
  return 0;
}

// 程序的入口
class MyMessageServerApp extends StatefulWidget {
  // This widget is the root of your application.
  int themeIndex;

  MyMessageServerApp(this.themeIndex);

  @override
  MyMessageServerAppState createState() => MyMessageServerAppState();
}

// 程序的入口
class MyMessageServerAppState extends State<MyMessageServerApp> {
  Color themeColor;

  @override
  void initState() {
    super.initState();
    themeColor = ThemeConstant.supportColors[widget.themeIndex];
    this.registerThemeEvent();
  } // This widget is the root of your application.

  void registerThemeEvent() {
    CommonConstant.eventBus
        .on<ThemeEvent>()
        .listen((ThemeEvent onData) => this.changeTheme(onData));
  }

  void changeTheme(ThemeEvent onData) async {
    setState(() {
      themeColor = ThemeConstant.supportColors[onData.themeIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    /// IOS 主题
    ThemeData ios = new ThemeData(
      brightness: Brightness.light,
      primaryColor: themeColor,
      accentColor: Color(0xFF5fc2ed),
    );

    /// android 主题
    ThemeData android = new ThemeData(
      brightness: Brightness.light,
      primaryColor: themeColor,
      accentColor: Color(0xFF5fc2ed),
    );

    return MaterialApp(
      theme: Platform.isAndroid ? android : ios,
      title: 'ToYou',
      home: TransitionPage(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    CommonConstant.eventBus.destroy();
  }
}
