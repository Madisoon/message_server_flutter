import 'package:flutter/material.dart';
import 'dart:convert';
import './InformationDetailPage.dart';
import '../utils/CommonOperation.dart';
import '../utils/ApiUtils.dart';
import '../api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagePostPage extends StatefulWidget {
  MessagePostPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MessagePostPageState createState() => MessagePostPageState();
}

class MessagePostPageState extends State<MessagePostPage>
    with AutomaticKeepAliveClientMixin {
  var listData = [];

  /// 第1页
  var curPage = 1;

  /// 每页20条数据
  var curSize = 20;

  /// 是否已经获取全部数据
  bool loadingStatus = false;

  /// 是否展示没有数据时的空白页面
  bool emptyPageStatus = false;

  /// 定义滚动控制变量
  ScrollController _scrollController = new ScrollController();

  // 防止下拉过程不断的请求
  bool isPerformingRequest = false;

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMorePostInformation();
      }
    });
    CommonOperation.appUIStyle();
    getPostInformation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getMorePostInformation() async {
    if (!isPerformingRequest && !loadingStatus) {
      setState(() => isPerformingRequest = true);
      setState(() {
        isPerformingRequest = false;

        /// 加载更多数据的实现
      });
    }
  }

  /// 获取需要推送的信息
  getPostInformation() async {
    setState(() {
      curPage = 1;
      emptyPageStatus = false;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ApiUtils.get(Api.baseUrl + "yuqingmanage/manage/getInforPostByGet")
        .then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);

        /// 三种情况  有数据，还有下一页
        /// 有数据，没有下一页
        /// 没有数据
        if (listData == null || listData.length == 0) {
          setState(() {
            loadingStatus = true;
            emptyPageStatus = true;
          });
        } else if (listData.length < curSize) {
          setState(() {
            loadingStatus = true;
          });
        } else {
          setState(() {
            loadingStatus = false;
          });
        }
        setState(() {
          listData = map['data'];
        });
      }
    });
  }

  Future<Null> handleRefresh() async {
    // 延迟一秒加载
    await Future.delayed(Duration(seconds: 1), () {
      this.getPostInformation();
    });
  }

  /// 完成推送的信息
  finishPostInformation(BuildContext context, String id, int index) {
    Map<String, String> map = {'inforId': id, 'userLoginName': 'admin'};
    ApiUtils.post(
            "http://114.115.253.92:8080/yuqingmanage/manage/updateInforPost",
            params: map)
        .then((data) {
      setState(() {
        listData.removeAt(index);
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          '完成推送',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF7a77bd),
      ));
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

  void getNumber() {}

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
                  maxLines: 2,
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
      subtitle: new Row(
        children: <Widget>[
          new Expanded(
              child: new Text(
                  CommonOperation.getInformationType(map['infor_post_type']))),
          new Text(DateTime.now().toString().substring(0, 16))
        ],
      ),
      /*trailing: IconButton(
        icon: Icon(Icons.playlist_play),
        onPressed: getNumber,
      ),*/
      onTap: () {
        /// 跳转到信息详情页面
        Navigator.push<String>(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new InformationDetailPage(information: map);
        })).then((String id) {
          if (id != null && id != '') {
            setState(() {
              listData.removeWhere((item) => id == item['id']);
            });
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red.shade700,
                content: Text(
                  '删除成功',
                  style: TextStyle(color: Colors.white),
                )));
          }
        });
      },
    );
  }

  /// 构建信息推送的列表
  Widget buildMessageList() {
    return ListView.builder(
      padding: EdgeInsets.all(1.0),
      // list的个数
      itemCount: listData != null ? listData.length + 1 : 0,
      itemBuilder: (BuildContext context, int index) {
        if (index == listData.length) {
          return _buildProgressIndicator();
        } else {
          return Dismissible(
            key: Key(listData[index]['id']),
            onDismissed: (direction) {
              this.finishPostInformation(context, listData[index]['id'], index);
            },
            child: new Container(
              child: new Column(
                children: <Widget>[
                  buildListData(context, listData[index],
                      Icon(Icons.star, color: Colors.green)),
                  new Divider()
                ],
              ),
            ),
            background: Container(
              color: Colors.grey,
            ),
          );
        }
      },
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget page =
        emptyPageStatus ? new Center(child: Text('空空如也')) : buildMessageList();
    return Scaffold(
      body: new RefreshIndicator(
        child: buildMessageList(),
        color: Color(0xFF7a77bd),
        onRefresh: handleRefresh,
      ),
    );
  }
}
