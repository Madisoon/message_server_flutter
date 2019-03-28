import 'package:flutter/material.dart';

import '../constants/CommonConstant.dart';
import './SystemNoticePage.dart';
import './PersonInformationPage.dart';
import './SystemSettingPage.dart';
import './InformationStatisticsPage.dart';
import '../utils/CommonDataUtils.dart';
import './MessageMonitorPage.dart';
import './MessagePostPage.dart';
import './DifferentTypeInformation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_event.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage>
    with SingleTickerProviderStateMixin {
  List tabs = [
    "推送",
    "监控",
    "展示" /*, "历史", "回收站"*/
  ];

  List<Map> listOperation = CommonConstant.listOperation;

  String nickName = "";
  String phone = "";

  @override
  initState() {
    super.initState();
    this.changeTheme();
    CommonDataUtils.getSysUser().then((sysUser) {
      setState(() {
        nickName = sysUser.nickName;
        phone = sysUser.phone;
      });
    });
  }

  changeTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeIndex", 3);
    CommonConstant.eventBus.fire(new ThemeEvent(3));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> renderPersonOperation() {
    List<Widget> list = [];
    list.add(
      new UserAccountsDrawerHeader(
        accountName: new Text(
          nickName,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        accountEmail: new Text(
          phone,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        currentAccountPicture: new CircleAvatar(
          backgroundImage: new AssetImage("lib/images/header.jpg"),
        ),
        onDetailsPressed: () {
          Navigator.push<String>(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new PersonInformationPage();
          })).then((String id) {});
        },
        decoration: new BoxDecoration(color: Color(0xFF7a77bd)
            /*image: DecorationImage(
            image: AssetImage("lib/images/person_back.png"),
            fit: BoxFit.fill,
          ),*/
            ),
      ),
    );
    this.listOperation.forEach((item) {
      if (item['name'] == '统计') {
        list.add(new Container(
          height: 6,
          color: Color(0xfff8f6f2),
        ));
      }
      list.add(new InkWell(
        onTap: () {
          /// 需要进行页面的跳转
          switch (item['name']) {
            case '设置':
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new SystemSettingPage();
              })).then((String id) {});
              break;
            case '个人中心':
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new PersonInformationPage();
              })).then((String id) {});
              break;
            case "通知":
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new SystemNoticePage();
              })).then((String id) {});
              break;
            case '统计':
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new InformationStatisticsPage();
              })).then((String id) {});
              break;
            default:
              break;
          }
        },
        child: new Container(
          padding: EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 10),
          child: new Row(
            children: <Widget>[
              new Icon(
                item['icon'],
                size: 18,
                color: Color(0xffacacac),
              ),
              new Expanded(
                  child: new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Text(item['name']),
              ))
            ],
          ),
        ),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 5,
        child: Scaffold(
          // 这是中间内容
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text('信息管理'),
            bottom: new PreferredSize(
              preferredSize: Size.fromHeight(28.0),
              child: TabBar(
                  //生成Tab菜单
                  tabs: tabs
                      .map((e) => new Container(
                            height: 38,
                            child: Tab(text: e),
                          ))
                      .toList()),
            ),
          ),
          drawer: new Drawer(
            child: ListView(
              padding: const EdgeInsets.only(),
              children: this.renderPersonOperation(),
            ),
          ),
          body: new TabBarView(
            children: [
              MessagePostPage(),
              MessageMonitorPage(),
              DifferentTypeInformation(),
            ],
          ),
        ));
  }
}
