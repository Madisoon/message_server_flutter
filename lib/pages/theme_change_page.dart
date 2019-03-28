import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_event.dart';
import '../constants/CommonConstant.dart';

class ThemeChangePage extends StatefulWidget {
  ThemeChangePage({Key key}) : super(key: key);

  @override
  ThemeChangePageState createState() => ThemeChangePageState();
}

class ThemeChangePageState extends State<ThemeChangePage> {
  @override
  void initState() {
    super.initState();
  }

  changeTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeIndex", 1);
    CommonConstant.eventBus.fire(new ThemeEvent(1));
  }

  @override
  Widget build(BuildContext context) {}
}
