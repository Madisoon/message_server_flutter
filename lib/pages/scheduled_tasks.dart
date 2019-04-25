import 'package:flutter/material.dart';
import 'dart:convert';
import '../utils/ApiUtils.dart';
import './scheduled_tasks_detail.dart';
import '../api/api.dart';

class ScheduledTasks extends StatefulWidget {
  ScheduledTasks({Key key}) : super(key: key);

  @override
  ScheduledTasksState createState() => ScheduledTasksState();
}

class ScheduledTasksState extends State<ScheduledTasks> {
  List planList = [];

  @override
  void initState() {
    super.initState();
    this.listPushPlan();
  }

  listPushPlan() {
    ApiUtils.post(Api.baseUrl + "yuqingmanage/manage/getAllPlan", params: {})
        .then((data) {
      print(data);
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        setState(() {
          planList = map['data'];
        });
      }
    });
  }

  List<Widget> renderPlanList() {
    List<Widget> list = [];
    planList.forEach((item) {
      list.add(Card(
          child: InkWell(
        onTap: () {
          Navigator.push<String>(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return ScheduledTasksDetail(
              scheduledInformation: item,
            );
          })).then((String id) {});
        },
        child: new Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: Color(0xFF00c1d0), width: 2.6))),
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            item['plan_name'],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: new Text(
                              item['plan_remark'],
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.grey,
                    )
                  ],
                )),
          ),
        ),
      )));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('计划任务'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: '添加计划任务',
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: this.renderPlanList(),
        ),
      ),
    );
  }
}
