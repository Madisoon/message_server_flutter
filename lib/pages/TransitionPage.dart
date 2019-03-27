import 'dart:async';

import 'package:flutter/material.dart';
import './HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './LoginPage.dart';
import 'package:flare_flutter/flare_actor.dart';

/// 三秒开屏页
class TransitionPage extends StatefulWidget {
  TransitionPage({Key key}) : super(key: key);

  @override
  TransitionPageState createState() => TransitionPageState();
}

class TransitionPageState extends State<TransitionPage> {
  Widget showPage = LoginPage();
  bool startPageStatus = false;
  Timer countdownTimer;
  int countdownNum = 4;

  @override
  initState() {
    super.initState();
    reGetCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    countdownTimer = null;
    super.dispose();
  }

  /// 三秒定时器
  void reGetCountdown() {
    countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (countdownNum == 0) {
        countdownTimer?.cancel();
        indexOrLoginPage();
        return;
      }
      setState(() {
        countdownNum--;
      });
    });
  }

  /// 判断 展示登陆页面还是主页面
  indexOrLoginPage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("LOGIN_SUCCESS") != null &&
        sharedPreferences.getBool("LOGIN_SUCCESS")) {
      showPage = new HomePage(title: '推你');
    } else {
      showPage = new LoginPage();
    }
    if (!startPageStatus) {
      //跳转主页 且销毁当前页面
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => showPage),
          (Route<dynamic> rout) => false);
      startPageStatus = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: new GestureDetector(
        onTap: indexOrLoginPage, //设置页面点击事件
        child: FlareActor("lib/images/flash_screen.flr",
            fit: BoxFit.fill,
            animation: "success",
            alignment: Alignment
                .center), /*Image.asset("lib/images/qixi.jpeg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity),*/ //此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
      ),
    ));
  }
}
