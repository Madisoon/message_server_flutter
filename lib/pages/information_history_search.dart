import 'package:flutter/material.dart';

class InformationHistorySearch extends StatefulWidget {
  InformationHistorySearch({Key key}) : super(key: key);

  @override
  InformationHistorySearchState createState() =>
      InformationHistorySearchState();
}

class InformationHistorySearchState extends State<InformationHistorySearch> {
  /// 焦点兼听监听事件
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // TextField has lost focus
        print('获取焦点');
      } else {
        print('失去焦点');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Color(0xFFf8f6f2),
      child: ListView(
        children: <Widget>[
          Container(
            color: Color(0xFFffffff),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            height: 50.0,
            child: new Row(
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: new Icon(
                    Icons.chevron_left,
                    color: Color(0xFF7a77bd),
                  ),
                ),
                new Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 40.0,
                    color: Color(0xFFf8f6f2),
                    child: Row(
                      children: <Widget>[
                        new Container(
                          width: 40.0,
                          child: new Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 22,
                          ),
                        ),
                        new Expanded(
                            child: new TextField(
                          focusNode: _focusNode,
                          onChanged: (String value) {},
                          decoration: InputDecoration.collapsed(
                            hintText: '试试看',
                          ),
                        )),
                        new Container(
                          margin: EdgeInsets.only(right: 10),
                          child: new Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 10),
                  child: new Text(
                    '搜索',
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF7a77bd)),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            height: 36,
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new Text(
                    '开始时间',
                  ),
                ),
                new Text(
                  '请选择',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            height: 36,
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new Text(
                    '结束时间',
                  ),
                ),
                new Text(
                  '请选择',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
