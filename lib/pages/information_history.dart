import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import '../utils/ApiUtils.dart';
import '../api/api.dart';
import './information_history_search.dart';

/// 推送历史
class InformationHistory extends StatefulWidget {
  InformationHistory({Key key}) : super(key: key);

  @override
  InformationHistoryState createState() => InformationHistoryState();
}

class InformationHistoryState extends State<InformationHistory> {
  List historyData = [];

  /// 数据是否加载完
  bool loadingStatus = false;

  /// 第几页
  num pageNumber = 1;

  /// 每页条数
  num pageSize = 25;

  /// 是否展示没有数据时的空白页面
  bool emptyPageStatus = false;

  // 防止下拉过程不断的请求
  bool isPerformingRequest = false;

  String startTime = '';
  String endTime = '';
  String keyWord = '';

  String informationStatus = "0";

  bool searchShowStatus = false;

  /// 定义滚动控制变量
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    this.listPushInformation(true);

    /// 添加滚动监听事件
    _scrollController.addListener(() {
      /// 判断是否滚动到最底层
      bool flag = _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent;
      if (flag) {
        this.listMoreInformation();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  listMoreInformation() {
    if (!isPerformingRequest && !loadingStatus) {
      setState(() => isPerformingRequest = true);
      this.listPushInformation(false);
    }
  }

  clearSearch() {
    setState(() {
      this.searchShowStatus = false;
    });
    this.startTime = '';
    this.endTime = '';
    this.keyWord = '';
  }

  /// 判断是否需要清空赋值
  listPushInformation(clearType) {
    if (clearType) {
      this.pageNumber = 1;
    } else {
      this.pageNumber++;
    }

    Map<String, String> param = {
      'pageNumber': this.pageNumber.toString(),
      'pageSize': this.pageSize.toString(),
      'startTime': this.startTime,
      'endTime': this.endTime,
      'keyWord': this.keyWord,
      'deleteStatus': this.informationStatus,
    };

    /// Api.baseUrl
    ApiUtils.get(Api.baseUrl + "yuqingmanage/manage/listPushInformation",
            params: param)
        .then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        if (map['data'] == null || map['data'].length == 0) {
          setState(() {
            loadingStatus = true;
            this.historyData = [];
          });
        } else {
          if (clearType) {
            this.historyData = map['data'];
          } else {
            this.historyData.addAll(map['data']);
          }
          if (map['data'].length < this.pageSize) {
            setState(() {
              loadingStatus = true;
            });
          } else {
            setState(() {
              loadingStatus = false;
            });
          }
        }
      }
      setState(() => isPerformingRequest = false);
    });
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
    await Future.delayed(Duration(seconds: 1), () {
      this.clearSearch();
      this.listPushInformation(true);
    });
  }

  Widget searchToolShow() {
    String searchExplain = '';
    if (this.startTime != '' || this.endTime != '') {
      if (this.startTime != '' && this.endTime == '') {
        searchExplain = '时间：${this.startTime}之后';
      } else if (this.startTime == '' && this.endTime != '') {
        searchExplain = '时间：截止${this.endTime}';
      } else {
        searchExplain = '时间：${this.startTime} 至 ${this.endTime}';
      }
    }
    if (this.keyWord != '') {
      if (searchExplain != '') {
        searchExplain += '  |  关键词：${this.keyWord}';
      } else {
        searchExplain += '关键词：${this.keyWord}';
      }
    }
    return this.searchShowStatus
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            width: double.infinity,
            color: Color(0xFF00c1d0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new Text(
                    searchExplain,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      this.searchShowStatus = false;
                    });
                    this.clearSearch();
                    this.listPushInformation(true);
                  },
                  child: Icon(
                    Icons.clear,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        : Container();
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
                buildListData(context, historyData[index]),
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

  Widget buildListData(BuildContext context, Map map) {
    /// list中的单个人元素的样式
    return new ListTile(
      isThreeLine: false,
      /*leading: iconItem,GestureDetector,手势相关*/
      title: new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Align(
              child: new Text(
                map['infor_title'].toString().trim(),
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
                  map['infor_context'].toString().trim(),
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
            children: this.buildPostCustomer(map['infor_numbers']),
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new Text(map['infor_createtime'])),
              new Text(map['infor_site'])
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildPostCustomer(postCustomer) {
    List list = postCustomer.toString().split(',');
    List<Widget> customerView = [];
    list.forEach((item) {
      customerView.add(Container(
        child: Chip(
          avatar: Icon(Icons.person_outline, color: Color(0xFF00c1d0)),
          label: Text(item),
        ),
      ));
    });
    return customerView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('信息管理'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              this.informationStatus = result;
              this.listPushInformation(true);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: '0',
                    child: Text('正常'),
                  ),
                  const PopupMenuItem<String>(
                    value: '1',
                    child: Text('回收站'),
                  ),
                ],
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '筛选',
            onPressed: () {
              Navigator.push<Map>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new InformationHistorySearch();
              })).then((Map data) {
                if (data != null) {
                  setState(() {
                    this.startTime = data['startTime'];
                    this.endTime = data['endTime'];
                    this.keyWord = data['keyWord'];
                  });
                  setState(() {
                    this.searchShowStatus = true;
                  });
                  this.listPushInformation(true);
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.searchToolShow(),
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
