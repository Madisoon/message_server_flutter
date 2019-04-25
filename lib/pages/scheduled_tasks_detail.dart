import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 计划任务详情页面
class ScheduledTasksDetail extends StatefulWidget {
  Map scheduledInformation;

  ScheduledTasksDetail({Key key, this.scheduledInformation}) : super(key: key);

  @override
  ScheduledTasksDetailState createState() => ScheduledTasksDetailState();
}

class ScheduledTasksDetailState extends State<ScheduledTasksDetail> {
  /// 标题输入控制器
  TextEditingController titleController;

  /// 内容输入控制器
  TextEditingController remarkController;

  /// 标题输入控制器
  TextEditingController startController;

  /// 内容输入控制器
  TextEditingController endController;

  String startTime;
  String endTime;

  @override
  void initState() {
    super.initState();
    startTime = widget.scheduledInformation['day_one'].toString().split('-')[0];
    endTime = widget.scheduledInformation['day_one'].toString().split('-')[1];
    titleController = new TextEditingController.fromValue(
        new TextEditingValue(text: widget.scheduledInformation['plan_name']));
    remarkController = new TextEditingController.fromValue(
        new TextEditingValue(text: widget.scheduledInformation['plan_remark']));
    startController = new TextEditingController.fromValue(
        new TextEditingValue(text: startTime));
    endController = new TextEditingController.fromValue(
        new TextEditingValue(text: endTime));
  }

  _showTimePicker(type) async {
    await showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (type == 'start') {
        this.startTime = '${value.hour}:${value.minute}';
        this.startController.text = startTime;
      } else {
        setState(() {
          this.endTime = '${value.hour}:${value.minute}';
          this.endController.text = endTime;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('详情'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: '标题'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: '备注'),
              controller: remarkController,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '时间段',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 32.0,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Color(0xfff1f1f1), //阴影颜色
                                    blurRadius: 10.0, //阴影大小
                                  ),
                                ],
                                borderRadius: new BorderRadius.circular(32.0)),
                            child: new TextField(
                              controller: startController,
                              textAlign: TextAlign.center,
                              onTap: () {
                                this._showTimePicker('start');
                              },
                              onChanged: (String value) {},
                              decoration: InputDecoration.collapsed(
                                  hintText: '开始时间',
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 14)),
                            ),
                          ),
                          flex: 1,
                        ),
                        Container(
                          child: Text('至'),
                          margin: EdgeInsets.only(left: 10, right: 10),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 18),
                            alignment: Alignment.center,
                            height: 32.0,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Color(0xfff1f1f1), //阴影颜色
                                    blurRadius: 10.0, //阴影大小
                                  ),
                                ],
                                borderRadius: new BorderRadius.circular(32.0)),
                            child: new TextField(
                              controller: endController,
                              onTap: () {
                                this._showTimePicker('end');
                              },
                              onChanged: (String value) {},
                              decoration: InputDecoration.collapsed(
                                  hintText: '结束时间',
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 14)),
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
