import 'package:flutter/material.dart';
import '../utils/CommonOperation.dart';
import '../utils/ApiUtils.dart';

/// 推送消息详情页面
class InformationDetailPage extends StatefulWidget {
  InformationDetailPage({Key key, this.information}) : super(key: key);
  final Map information;

  @override
  InformationDetailPageState createState() =>
      InformationDetailPageState(information);
}

class InformationDetailPageState extends State<InformationDetailPage> {
  final TextEditingController accountController = new TextEditingController();
  final Map information;
  var scaffoldInformationDetailKey = new GlobalKey<ScaffoldState>();

  InformationDetailPageState(this.information);

  TextStyle textStyle = new TextStyle(color: Colors.grey);

  /// 信息分享到微信和qq
  informationShareWeChatAndQq() {}

  String informationContentFormat() {
    String title = this.information['infor_title'].toString().trim();
    String content = this.information['infor_context'].toString().trim();
    String link = this.information['infor_link'].toString().trim();
    String site = this.information['infor_site'].toString().trim();

    String copyContent = '标题：$title\n'
        '内容：$content\n'
        '链接：\n'
        '$link\n'
        '站点：$site\n';
    return copyContent;
  }

  copyInformationContent() {
    scaffoldInformationDetailKey.currentState.showSnackBar(SnackBar(
        content: Text(
      '复制成功',
      style: TextStyle(color: Colors.redAccent),
    )));
    CommonOperation.copyToClipboard(informationContentFormat());
  }

  /// 删除需要推送的信息
  deletePostInformation(BuildContext context, String id) {
    Map<String, String> map = {'inforId': id};
    ApiUtils.post(
            "http://114.115.253.92:8080/yuqingmanage/manage/deleteInforPost",
            params: map)
        .then((data) {
      Navigator.pop(context, id);
    });
  }

  /// 信息分享到微信和qq
  informationOnPressCopy() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('请选择需要进行的操作'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  this.copyInformationContent();
                },
                child: Text(
                  '复制',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: Text(
                  '分享',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  this.deletePostInformation(context, information['id']);
                },
                child: Text(
                  '删除',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldInformationDetailKey,
        appBar: AppBar(
          title: Text('详情'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              tooltip: '分享',
              onPressed: () {
                this.informationShareWeChatAndQq();
              },
            ),
            IconButton(
              icon: Icon(Icons.content_copy),
              tooltip: '复制',
              onPressed: () {
                this.copyInformationContent();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              tooltip: '删除',
              onPressed: () {
                this.deletePostInformation(context, information['id']);
              },
            ),
          ],
        ),
        body: GestureDetector(
          onLongPress: informationOnPressCopy,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    new Align(
                      child: new Text(
                        information['infor_title'].toString().trim(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      alignment: FractionalOffset.centerLeft,
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 4, bottom: 4.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new Text(
                            '接收方：' +
                                information['infor_get_people'] +
                                '-' +
                                information['get_remark'],
                            style: textStyle,
                          ))
                        ],
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          "类型：" +
                              CommonOperation.getInformationType(
                                  information['infor_post_type']),
                          style: textStyle,
                        )),
                        new Text(
                          "站点：" + information['infor_site'],
                          style: textStyle,
                        ),
                      ],
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 4, bottom: 4.0),
                      child: new Row(
                        children: <Widget>[
                          new Text(
                            '链接：' +
                                information['infor_link']
                                    .toString()
                                    .substring(0, 30),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    new Text(information['infor_context'].toString().trim()),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
