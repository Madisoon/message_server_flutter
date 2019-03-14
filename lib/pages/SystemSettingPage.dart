import 'package:flutter/material.dart';

/// 系统设置相关页面
class SystemSettingPage extends StatefulWidget {
  SystemSettingPage({Key key}) : super(key: key);
  Color colorBack = Colors.white;

  @override
  SystemSettingPageState createState() => SystemSettingPageState();
}

class SystemSettingPageState extends State<SystemSettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('设置'),
          actions: <Widget>[],
        ),
        body: Container(
          color: Color(0xFFf8f6f2),
          child: ListView(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 18),
                color: widget.colorBack,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new GestureDetector(
                  onVerticalDragDown: (DragDownDetails details) {
                    setState(() {
                      widget.colorBack = Color(0xffbdbdbd);
                    });
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                    setState(() {
                      widget.colorBack = Colors.white;
                    });
                  },
                  onVerticalDragCancel: () {
                    setState(() {
                      widget.colorBack = Colors.white;
                    });
                  },
                  onVerticalDragUpdate: (DragUpdateDetails details) {},
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                        '安全设置',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      )),
                      new Icon(
                        Icons.chevron_right,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: new Divider(
                  height: 1,
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      '生物识别',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                    new Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 18),
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      '安全设置',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                    new Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: new Divider(
                  height: 1,
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      '生物识别',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                    new Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 18),
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      '支付设置',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                    new Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: new Divider(
                  height: 1,
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      '通用',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                    new Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: new Divider(
                  height: 1,
                ),
              ),
              new Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, right: 8, left: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                      '快捷方式',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )),
                    new Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
