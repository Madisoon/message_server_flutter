import 'package:flutter/material.dart';

class SearchManager extends StatefulWidget {
  SearchManager({Key key}) : super(key: key);

  @override
  SearchManagerState createState() => SearchManagerState();
}

class SearchManagerState extends State<SearchManager> {
  @override
  void initState() {
    super.initState();
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
                          onChanged: (String value) {},
                          decoration: InputDecoration.collapsed(
                            hintText: '试试看',
                          ),
                        )),
                        new Container(
                          margin: EdgeInsets.only(right: 10),
                          child: new Icon(
                            Icons.music_note,
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
          )
        ],
      ),
    )));
  }
}
