import 'package:flutter/material.dart';

import 'dart:convert';
import '../utils/ApiUtils.dart';

@immutable
class TagManage extends StatefulWidget {
  TagManage({Key key}) : super(key: key);
  Color indexBarColor = Colors.transparent;

  String currentLetterShow = '';

  @override
  TagManageState createState() => TagManageState();
}

class TagManageState extends State<TagManage> {
  TextEditingController tagNameController;

//  final String tagIndex = 'tagIndex';
//  final String tagId = 'id';
//  final String tagName = 'tagName';
//  final String checkStatus = 'checkStatus';

  final String tagIndex = 'name_index';
  final String tagId = 'id';
  final String tagName = 'name';
  final String checkStatus = 'checkStatus';

  ScrollController scrollController;
  var allTag = [];
  var letter = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  final Map letterPositionMap = {'A': 0};

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    tagNameController =
        new TextEditingController.fromValue(new TextEditingValue(text: ''));
    getAllTag();
  }

  /// 新建标签
  insertTag() {
    // 添加完成将对象返回回来
    tagNameController.text = '';
  }

  listTagIndex() {
    ApiUtils.get('http://localhost:5678/push-you-service/tag/listTagIndex')
        .then((data) {
      List list = json.decode(data);
      var letterData = [];
      list.forEach((item) {
        letterData.add(item[tagIndex]);
      });

      setState(() {
        letter = letterData;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  /// 获取所有标签
  getAllTag() {
    ApiUtils.post("http://114.115.253.92:8080/yuqingmanage/manage/getAllTag")
        .then((data) {
      var totalPosition = 0.0;
      setState(() {
        Map<String, dynamic> map = json.decode(data);
        allTag = map['data'];
        allTag.sort(
            (a, b) => a[tagIndex].toString().compareTo(b[tagIndex].toString()));
        List.generate(allTag.length, (index) {
          bool groupTitleStatus = true;
          if (index >= 1 &&
              allTag[index][tagIndex] == allTag[index - 1][tagIndex]) {
            groupTitleStatus = false;
          }

          if (groupTitleStatus) {
            letterPositionMap[allTag[index][tagIndex]] = totalPosition;
            totalPosition += 70;
          } else {
            totalPosition += 45;
          }
        });
      });
    });
  }

  List<Widget> renderLetter() {
    List<Widget> list = [];
    List.generate(letter.length, (index) {
      list.add(new Expanded(
        child: new Text(
          letter[index],
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ));
    });
    return list;
  }

  double getHeight(bool hasGroupTitle) {
    double height = 0;
    if (hasGroupTitle) {
      height = 30.0 + 16.0;
    } else {
      height = 30.0 + 16.0;
    }
    return height;
  }

  Widget buildItemTagWidget(var data, bool groupStatus) {
    Widget itemBody = new InkWell(
      onTap: () {},
      child: new Container(
        height: 45,
        child: new Row(
          children: <Widget>[
            new Container(
              width: 60,
              height: 45,
              child: new Icon(
                Icons.donut_small,
                color: Color(0xFF7a77bd),
                size: 30,
              ),
            ),
            new Expanded(
                child: new Container(
              height: 45,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: new Text(
                data[tagName],
                style: TextStyle(fontSize: 15),
              ),
            ))
          ],
        ),
      ),
    );

    if (groupStatus != null && groupStatus) {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 14),
            height: 25,
            color: Colors.black12,
            child: new Align(
              alignment: Alignment.centerLeft,
              child: new Text(data[tagIndex]),
            ),
          ),
          itemBody
        ],
      );
    } else {
      return itemBody;
    }
  }

  String getLetter(BuildContext context, double tagHeight, Offset globalPos) {
    RenderBox renderBox = context.findRenderObject();
    var local = renderBox.globalToLocal(globalPos);
    int index = (local.dy ~/ tagHeight).clamp(0, letter.length - 1);
    return letter[index];
  }

  void jumpToIndex(String letter) {
    if (letterPositionMap.isNotEmpty) {
      final pos = letterPositionMap[letter];
      if (pos != null) {
        scrollController.animateTo(
          pos,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }
  }

  Widget buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final double totalHeight = constraints.biggest.height;
    final double tagHeight = totalHeight / letter.length;

    return new GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          widget.indexBarColor = Colors.black26;
          widget.currentLetterShow =
              getLetter(context, tagHeight, details.globalPosition);
          jumpToIndex(widget.currentLetterShow);
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          widget.indexBarColor = Colors.transparent;
          widget.currentLetterShow = '';
        });
      },
      onVerticalDragCancel: () {
        setState(() {
          widget.indexBarColor = Colors.transparent;
          widget.currentLetterShow = '';
        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          widget.currentLetterShow =
              getLetter(context, tagHeight, details.globalPosition);
          jumpToIndex(widget.currentLetterShow);
        });
      },
      child: Column(
        children: renderLetter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      new Container(
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          controller: scrollController,
          children: List.generate(allTag.length, (index) {
            bool groupTitleStatus = true;
            if (index >= 1 &&
                allTag[index][tagIndex] == allTag[index - 1][tagIndex]) {
              groupTitleStatus = false;
            }
            return buildItemTagWidget(allTag[index], groupTitleStatus);
          }),
        ),
      ),
      new Positioned(
        right: 5.0,
        top: 8.0,
        bottom: 40.0,
        width: 16.0,
        child: new Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: LayoutBuilder(builder: buildIndexBar),
          decoration: new BoxDecoration(
            color: widget.indexBarColor,
            borderRadius: new BorderRadius.vertical(
                top: Radius.elliptical(16, 16),
                bottom: Radius.elliptical(16, 16)),
          ),
        ),
      )
    ];

    if (widget.currentLetterShow != null &&
        widget.currentLetterShow.isNotEmpty) {
      body.add(Center(
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
              color: Color(0xFF7a77bd),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Center(
            child: new Text(
              widget.currentLetterShow,
              style: TextStyle(fontSize: 64, color: Colors.white),
            ),
          ),
        ),
      ));
    }
    return Scaffold(
        appBar: new AppBar(
          title: new Text('选择标签'),
          iconTheme: new IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              tooltip: '添加',
              onPressed: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('添加标签'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            new TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: '名称',
                              ),
                              onChanged: (String value) {},
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            '取消',
                            style: TextStyle(color: Color(0xFF00c1d0)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            '提交',
                            style: TextStyle(color: Color(0xFF7a77bd)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Stack(
          alignment: const Alignment(0.0, 40),
          children: body,
        ));
  }
}
