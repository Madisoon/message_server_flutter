import 'package:flutter/material.dart';
import 'dart:convert';
import '../constants/CommonConstant.dart';
import '../utils/ApiUtils.dart';
import './TagShowPage.dart';

/// 登陆页面
class MonitorInformationDetailPage extends StatefulWidget {
  MonitorInformationDetailPage({Key key, this.information}) : super(key: key);

  final Map information;

  @override
  MonitorInformationDetailPageState createState() =>
      MonitorInformationDetailPageState();
}

class MonitorInformationDetailPageState
    extends State<MonitorInformationDetailPage> {
  /// 标题输入控制器
  TextEditingController titleController;

  /// 内容输入控制器
  TextEditingController contentController;

  /// 链接输入控制器
  TextEditingController linkController;

  /// 站点输入控制器
  TextEditingController siteController;

  String sourceName;

  String sourceId = "1";

  List informationTagS = [];

  var myTag = [];

  @override
  void initState() {
    super.initState();
    sourceName = widget.information['infor_source'];
    List tagIdList = widget.information['tag_ids'].toString().split(',');
    List tagNameList = widget.information['tag_names'].toString().split(',');
    List.generate(tagIdList.length, (index) {
      Map map = new Map();
      map['id'] = tagIdList[index];
      map['name'] = tagNameList[index];
      informationTagS.add(map);
    });
    titleController = new TextEditingController.fromValue(
        new TextEditingValue(text: widget.information['infor_title']));
    contentController = new TextEditingController.fromValue(
        new TextEditingValue(text: widget.information['infor_context']));
    linkController = new TextEditingController.fromValue(
        new TextEditingValue(text: widget.information['infor_link']));
    siteController = new TextEditingController.fromValue(
        new TextEditingValue(text: widget.information['infor_site']));

    getMyTag();
  }

  /// 获取我的标签
  getMyTag() {
    Map<String, String> map = {'userLoginName': 'admin'};
    ApiUtils.post("http://114.115.253.92:8080/yuqingmanage/manage/getMyTag",
            params: map)
        .then((data) {
      Map<String, dynamic> map = json.decode(data);
      setState(() {
        myTag = map['data'];
      });
    });
  }

  /// 回收信息，删除按钮操作
  trashPostInformation(BuildContext context) {
    Map<String, String> map = {'id': widget.information['id'], 'isDelete': '1'};
    ApiUtils.post(
            "http://114.115.253.92:8080/yuqingmanage/manage/inforLogicOperation",
            params: map)
        .then((data) {
      Map map = {'id': widget.information['id'], 'type': 'trash'};
      Navigator.pop(context, map);
    });
  }

  /// 确认信息（两种情况，直接确认，修改信息之后确认）
  surePostInformation(BuildContext context) {
    Map<String, String> updateData = {
      'infor_title': titleController.text,
      'infor_context': contentController.text,
      'infor_link': linkController.text,
      'infor_site': siteController.text,
      'infor_source': sourceName,
      'infor_type': widget.information['infor_type'],
      'infor_grade': widget.information['infor_grade'],
    };
    Map<String, String> map = {
      'infoId': widget.information['id'],
      'type': 'monitorUpdate',
      'infoTagId': widget.information['tag_ids'],
      'infoData': json.encode(updateData).toString(),
    };
    ApiUtils.post(
            "http://114.115.253.92:8080/yuqingmanage/manage/updateInfoData",
            params: map)
        .then((data) {
      Map map = {'id': widget.information['id'], 'type': 'sure'};
      Navigator.pop(context, map);
    });
  }

  /// 弹出
  List<Widget> renderSource() {
    List<Widget> listSource = [];
    CommonConstant.source.forEach((item) {
      Color color =
          item['name'] == this.sourceName ? Colors.blue : Color(0xffacacac);
      listSource.add(SimpleDialogOption(
        onPressed: () {
          this.setState(() {
            this.sourceName = item['name'];
            this.sourceId = item['id'];
          });

          /// 返回到之前的页面
          Navigator.pop(context);
        },
        child: Text(
          item['name'],
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ));
    });
    return listSource;
  }

  /// 渲染信息标签
  renderInformationTag() {}

  chooseInformationSource() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('请选择信息来源'),
            children: this.renderSource(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('详情'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline),
            tooltip: '回收',
            onPressed: () {
              this.trashPostInformation(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.done_outline),
            tooltip: '确认',
            onPressed: () {
              this.surePostInformation(context);
            },
          ),
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(5.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                new Container(
                  child: new TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: '标题',
                    ),
                    onChanged: (String value) {},
                    controller: titleController,
                  ),
                ),
                new TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: '内容',
                  ),
                  onChanged: (String value) {},
                  controller: contentController,
                ),
                new TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: '链接',
                  ),
                  onChanged: (String value) {},
                  controller: linkController,
                ),
                new TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: '站点',
                  ),
                  onChanged: (String value) {},
                  controller: siteController,
                ),
                new Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: new GestureDetector(
                    onTap: chooseInformationSource,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: Text("来源:($sourceName)",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        new Text(
                          '选择来源',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Text("类型"),
                    new Radio(
                      value: "0",
                      groupValue: widget.information['infor_type'].toString(),
                      onChanged: (String value) {
                        this.setState(() {
                          widget.information['infor_type'] = value;
                        });
                      },
                    ),
                    new Text("敏感"),
                    new Radio(
                      value: "1",
                      groupValue: widget.information['infor_type'].toString(),
                      onChanged: (String value) {
                        this.setState(() {
                          widget.information['infor_type'] = value;
                        });
                      },
                    ),
                    new Text("非敏感")
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text("等级"),
                    new Radio(
                      value: "1",
                      groupValue: widget.information['infor_grade'].toString(),
                      onChanged: (String value) {
                        this.setState(() {
                          widget.information['infor_grade'] = value;
                        });
                      },
                    ),
                    new Text("1级"),
                    new Radio(
                      value: "2",
                      groupValue: widget.information['infor_grade'].toString(),
                      onChanged: (String value) {
                        this.setState(() {
                          widget.information['infor_grade'] = value;
                        });
                      },
                    ),
                    new Text("2级"),
                    new Radio(
                      value: "3",
                      groupValue: widget.information['infor_grade'].toString(),
                      onChanged: (String value) {
                        this.setState(() {
                          widget.information['infor_grade'] = value;
                        });
                      },
                    ),
                    new Text("3级")
                  ],
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.push<List>(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new TagShowPage(checkedTag: informationTagS);
                    })).then((List result) {
                      //处理代码
                      if (result != null && result.length != 0) {
                        setState(() {
                          informationTagS = result;
                        });
                      }
                    });
                  },
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          "信息标签：",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      new Text(
                        '选择全部标签',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                new Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: List.generate(informationTagS.length, (index) {
                    return Chip(
                      label: Text(informationTagS[index]['name'],
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Color(0xFF00c1d0),
                      deleteIcon:
                          Icon(Icons.clear, color: Colors.white, size: 20),
                      onDeleted: () {
                        setState(() {
                          informationTagS.removeWhere((item) =>
                              item['id'] == informationTagS[index]['id']);
                        });
                      },
                    );
                  }),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        "常用标签：",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Text(
                      '配置常用标签',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                new Wrap(
                  spacing: 16.0, // gap between adjacent chips
                  children: List.generate(myTag.length, (index) {
                    return new GestureDetector(
                      onTap: () {
                        bool flag = true;
                        informationTagS.forEach((item) {
                          if (item['id'] == myTag[index]['id']) {
                            flag = false;
                            return;
                          }
                        });
                        if (flag) {
                          setState(() {
                            informationTagS.add(myTag[index]);
                          });
                        }
                      },
                      child: Chip(
                          label: Text(myTag[index]['name'],
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Color(0xFF7a77bd)),
                    );
                  }),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
