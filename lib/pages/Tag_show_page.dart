import 'package:flutter/material.dart';
import 'dart:convert';
import '../utils/ApiUtils.dart';
import '../api/api.dart';

@immutable
class TagShowPage extends StatefulWidget {
  TagShowPage({Key key, this.checkedTag}) : super(key: key);

  List checkedTag;

  Color indexBarColor = Colors.transparent;

  String currentLetterShow = '';

  @override
  TagShowPageState createState() => TagShowPageState();
}

class TagShowPageState extends State<TagShowPage> {
  var throwShotAway = false;
  GlobalKey anchorKey = GlobalKey();

//  final String tagIndex = 'tagIndex';
//  final String tagId = 'id';
//  final String tagName = 'tagName';
//  final String checkStatus = 'checkStatus';

  final String tagIndex = 'name_index';
  final String tagId = 'id';
  final String tagName = 'name';
  final String checkStatus = 'checkStatus';

  ScrollController scrollController;

  var checkedTag = [];

  var allTag = [];
  var letter = [];
  final Map letterPositionMap = {'A': 0};

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();

    this.listTagIndex();

    /// 计算用于 IndexBar 进行定位的关键通讯录列表项的位置
    getAllTag();
  }

  listTagIndex() {
    ApiUtils.get(Api.baseUrl + 'yuqingmanage/manage/listTagIndex').then((data) {
      Map<String, dynamic> map = json.decode(data);
      List list = map['data'];
      var letterData = [];
      list.forEach((item) {
        letterData.add(item[tagIndex]);
      });
      setState(() {
        this.letter = letterData;
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
    Map<String, String> param = {'keyWord': ''};
    ApiUtils.post(Api.baseUrl + "yuqingmanage/manage/getAllTag", params: param)
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
          // 默认标签都是未被选中的状态
          allTag[index][checkStatus] = false;

          //如果id相等，就是已经被选中
          widget.checkedTag.forEach((item) {
            if (allTag[index][tagId] == item[tagId]) {
              allTag[index][checkStatus] = true;
              return;
            }
          });
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
      onTap: () {
        setState(() {
          data[checkStatus] = !data[checkStatus];
        });
        if (data[checkStatus]) {
          checkedTag.add(data);
        } else {
          checkedTag.removeWhere((item) => item[tagId] == data[tagId]);
        }
      },
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text(
                      data[tagName],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(right: 14),
                    child: new Checkbox(
                        value: data[checkStatus],
                        activeColor: Color(0xFF7a77bd),
                        onChanged: (bool newValue) {
                          setState(() {
                            data[checkStatus] = newValue;
                          });
                        }),
                  )
                ],
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: renderLetter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      new Container(
        padding: EdgeInsets.only(top: 6),
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
        right: 8.0,
        top: 8.0,
        bottom: 40.0,
        width: 20.0,
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
              icon: Icon(Icons.done, color: Colors.white),
              tooltip: '确认',
              onPressed: () {
                /// 返回到之前的页面
                Navigator.pop(context, checkedTag);
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
