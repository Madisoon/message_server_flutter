import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './information_history_search.dart';

/// 推送历史
class InformationHistory extends StatefulWidget {
  InformationHistory({Key key}) : super(key: key);

  @override
  InformationHistoryState createState() => InformationHistoryState();
}

class InformationHistoryState extends State<InformationHistory> {
  List historyData = [
    {'title': '1'},
    {'title': '1'}
  ];

  bool loadingStatus = false;

  /// 定义滚动控制变量
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  // 加载更多 Widget
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
          child: new Text(
        loadingStatus ? '已加载全部数据' : '努力加载中...',
        style: TextStyle(color: Colors.grey),
      )),
    );
  }

  Future<Null> handleRefresh() async {
    // 延迟一秒加载
    await Future.delayed(Duration(seconds: 1), () {});
  }

  /// 构建信息历史列表
  Widget buildMessageList() {
    return ListView.builder(
      padding: EdgeInsets.all(1.0),
      // list的个数
      itemCount: historyData != null ? historyData.length + 1 : 0,
      itemBuilder: (BuildContext context, int index) {
        if (index == historyData.length) {
          return _buildProgressIndicator();
        } else {
          return new Container(
            child: new Column(
              children: <Widget>[
                buildListData(context, historyData[index],
                    Icon(Icons.star, color: Colors.green)),
                new Divider()
              ],
            ),
          );
        }
      },
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget buildListData(BuildContext context, Map map, Icon iconItem) {
    /// list中的单个人元素的样式
    return new ListTile(
      isThreeLine: false,
      /*leading: iconItem,GestureDetector,手势相关*/
      title: new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Align(
              child: new Text(
                '高密普法 法治微课堂 老板谎称公司实行不定时工作制',
                /*map['infor_title'].toString().trim(),*/
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              ),
              alignment: FractionalOffset.centerLeft,
            ),
            new Container(
              margin: EdgeInsets.only(top: 4, bottom: 4.0),
              child: new Align(
                child: new Text(
                  '旷世奇才 发表于 2019-5-5 0806 文化路，'
                      '政府部门的路，好好弄弄，天天缝补丁干啥 '
                      '风光不再了，政府都没人了还修啥路。白搭了',
                  /*map['infor_context'].toString().trim(),*/
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, height: 1.4),
                ),
                alignment: FractionalOffset.centerLeft,
              ),
            )
          ],
        ),
        onHorizontalDragEnd: (endDetails) {},
      ),
      /*new Text(DateTime.now().toString())*/
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Wrap(
            spacing: 8.0,
            children: List.generate(4, (index) {
              return new GestureDetector(
                onTap: () {},
                child: Container(
                  child: Chip(
                    avatar:
                        Icon(Icons.person_outline, color: Color(0xFF7a77bd)),
                    label: Text('安徽宣传部'),
                  ),
                ),
              );
            }),
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new Text('2019-04-25 19:18')),
              new Text('35分钟')
              /*new Text(map['infor_site'])*/
            ],
          )
        ],
      ),
      /*trailing: IconButton(
        icon: Icon(Icons.playlist_play),
        onPressed: getNumber,
      ),*/
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('信息管理'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: '1',
                    child: Text('正常'),
                  ),
                  const PopupMenuItem<String>(
                    value: '0',
                    child: Text('回收站'),
                  ),
                ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            tooltip: '添加',
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '筛选',
            onPressed: () {
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new InformationHistorySearch();
              })).then((String id) {});
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(),
          Expanded(
            child: new RefreshIndicator(
              child: buildMessageList(),
              color: Color(0xFF7a77bd),
              onRefresh: handleRefresh,
            ),
          ),
        ],
      ),
    );
  }
}
