import 'package:flutter/material.dart';
import './scheduled_tasks.dart';
import './customer_management.dart';
import './MessageMonitorPage.dart';
import './tag_manage.dart';
import './SystemNoticePage.dart';
import './SystemSettingPage.dart';
import './SystemConfigurationPage.dart';

/// 系统配置页面（主页）
class SystemConfigurationPage extends StatefulWidget {
  SystemConfigurationPage({Key key}) : super(key: key);

  @override
  SystemConfigurationPageState createState() => SystemConfigurationPageState();
}

class SystemConfigurationPageState extends State<SystemConfigurationPage> {
  var menu = [
    {
      'name': '标签管理',
      'data': [
        {
          'name': '标签',
          'subtitle': '二级标题',
          'color': Color(0xFF4c96f4),
          'icon': Icons.map,
          'route': new TagManage()
        },
        {
          'name': '我的标签',
          'subtitle': '二级标题',
          'color': Color(0xFFf19850),
          'icon': Icons.add_to_queue,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '测试',
          'subtitle': '二级标题',
          'color': Color(0xFF96b988),
          'icon': Icons.add_to_queue,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '测试',
          'subtitle': '二级标题',
          'color': Color(0xFFbc261a),
          'icon': Icons.threesixty,
          'route': new SystemConfigurationPage()
        },
      ]
    },
    {
      'name': '信息展示，查询与统计',
      'data': [
        {
          'name': '信息展示',
          'subtitle': '二级标题',
          'color': Color(0xFF5ac7ae),
          'icon': Icons.message,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '推送历史',
          'subtitle': '二级标题',
          'color': Color(0xFFee6b2d),
          'icon': Icons.delete_sweep,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '信息统计',
          'subtitle': '二级标题',
          'color': Color(0xFF5fc2ed),
          'icon': Icons.developer_mode,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '测试',
          'subtitle': '二级标题',
          'color': Color(0xFF7a77bd),
          'icon': Icons.whatshot,
          'route': new SystemConfigurationPage()
        },
      ]
    },
    {
      'name': '推送设置',
      'data': [
        {
          'name': '推送计划',
          'subtitle': '二级标题',
          'color': Color(0xFF5ac7ae),
          'icon': Icons.threesixty,
          'route': new ScheduledTasks()
        },
        {
          'name': '客户',
          'subtitle': '二级标题',
          'color': Color(0xFFee6b2d),
          'icon': Icons.threesixty,
          'route': new CustomerManagement()
        },
        {
          'name': '方案',
          'subtitle': '二级标题',
          'color': Color(0xFF5fc2ed),
          'icon': Icons.threesixty,
          'route': new CustomerManagement()
        },
        {
          'name': '公告',
          'subtitle': '二级标题',
          'color': Color(0xFF7a77bd),
          'icon': Icons.threesixty,
          'route': new SystemConfigurationPage()
        },
      ]
    },
    {
      'name': '系统管理与配置',
      'data': [
        {
          'name': '部门管理',
          'subtitle': '二级标题',
          'color': Color(0xFF5ac7ae),
          'icon': Icons.threesixty,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '角色管理',
          'subtitle': '二级标题',
          'color': Color(0xFFee6b2d),
          'icon': Icons.threesixty,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '地区管理',
          'subtitle': '二级标题',
          'color': Color(0xFF5fc2ed),
          'icon': Icons.threesixty,
          'route': new SystemConfigurationPage()
        },
        {
          'name': '报告管理',
          'subtitle': '二级标题',
          'color': Color(0xFF7a77bd),
          'icon': Icons.threesixty,
          'route': new SystemConfigurationPage()
        },
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  /// 渲染单个菜单
  Widget renderSingleMenu(Map map) {
    return new Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            new GestureDetector(
              onTap: () => {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return map['route'];
                    }))
                  },
              child: new Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: map['color'],
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: new Center(
                  child: Icon(
                    map['icon'],
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
            new Positioned(
              bottom: 0,
              child: new Container(
                width: 48,
                child: new Center(
                  child: new Text(
                    map['name'],
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0))),
              ),
            )
          ],
        ),
        new Container(
          margin: EdgeInsets.only(top: 8),
          child: new Text(map['name']),
        )
      ],
    );
  }

  /// 渲染菜单列表
  List<Widget> renderSystemMenuListView() {
    List<Widget> list = [];

    /// 解析菜单数据
    List.generate(menu.length, (index) {
      List data = menu[index]['data'];
      List<Widget> singleMenuList = [];
      data.forEach((item) {
        singleMenuList.add(this.renderSingleMenu(item));
      });

      list.add(new Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              "${menu[index]['name']}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
            new Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: singleMenuList,
              ),
            )
          ],
        ),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('配置'),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 15, left: 15),
        child: ListView(
          children: this.renderSystemMenuListView(),
        ),
      ),
    );
  }
}
