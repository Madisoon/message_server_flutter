import 'package:flutter/material.dart';
import 'dart:convert';
import './MonitorInformationDetailPage.dart';
import '../utils/ApiUtils.dart';
import '../api/api.dart';

class MessageMonitorPage extends StatefulWidget {
  MessageMonitorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MessageMonitorPageState createState() => MessageMonitorPageState();
}

class MessageMonitorPageState extends State<MessageMonitorPage>
    with AutomaticKeepAliveClientMixin {
  var listData = [];

  /// 为了保存页面状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getMonitorInformation();
  }

  Future<Null> handleRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      this.getMonitorInformation();
    });
  }

  /// 需要监控的信息
  getMonitorInformation() {
    ApiUtils.get(Api.baseUrl +
            "yuqingmanage/manage/getMonitorInformation?pageNumber=1&pageSize=50")
        .then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        setState(() {
          listData = map['data'];
        });
      }
    });
  }

  /// 监控信息 放入回收站
  trashMonitorInformation() {}

  /// 监控信息 确认
  sureMonitorInformation() {}

  Widget buildListData(BuildContext context, Map map, Icon iconItem) {
    /// list中的单个人元素的样式

    print(map);
    return new ListTile(
      isThreeLine: false,
      title: new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Align(
              child: new Text(
                map['infor_title'].toString().trim(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 17),
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
      subtitle: new Row(
        children: <Widget>[
          new Expanded(child: new Text(map['infor_site'].toString().trim())),
          new Text(map['infor_createtime'].toString().substring(0, 16))
        ],
      ),
      /*trailing: IconButton(
        icon: Icon(Icons.playlist_play),
        onPressed: () {},
      ),*/
      onTap: () {
        /// 跳转到监控详情页面
        Navigator.push<Map>(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new MonitorInformationDetailPage(information: map);
        })).then((Map map) {
          /// 页面需要移除的id
          if (map != null && map['id'] != null && map['id'] != '') {
            if (map['type'] == 'trash') {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  '回收成功',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xFF7a77bd),
              ));
            }
            setState(() {
              listData.removeWhere((item) => item['id'] == map['id']);
            });
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
      itemCount: listData != null ? listData.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(listData[index]['id']),
          onDismissed: (direction) {
            setState(() {
              listData.removeAt(index);
            });
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red.shade700,
                content: Text(
                  '删除成功',
                  style: TextStyle(color: Colors.white),
                )));
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
      },
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 这是中间内容
      body: new RefreshIndicator(
        child: buildMessageList(),
        color: Color(0xFF7a77bd),
        onRefresh: handleRefresh,
      ),
    );
  }
}
