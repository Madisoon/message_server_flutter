import 'package:flutter/material.dart';

import './MessageMonitorPage.dart';
import './MessagePostPage.dart';
import './DifferentTypeInformation.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage>
    with SingleTickerProviderStateMixin {
  List tabs = ["推送", "监控", "展示", "历史", "回收站"];

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 5,
        child: Scaffold(
          // 这是中间内容
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text('信息管理'),
            bottom: TabBar(
                //生成Tab菜单
                tabs: tabs.map((e) => Tab(text: e)).toList()),
          ),
          body: new TabBarView(
            children: [
              MessagePostPage(),
              MessageMonitorPage(),
              DifferentTypeInformation(),
              MessageMonitorPage(),
              MessagePostPage()
            ],
          ),
        ));
  }
}
