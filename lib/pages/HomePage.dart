import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/CommonConstant.dart';
import './InformationPage.dart';
import './SystemNoticePage.dart';
import './PersonInformationPage.dart';
import './SystemSettingPage.dart';
import './theme_change_page.dart';
import './SystemConfigurationPage.dart';
import './InformationStatisticsPage.dart';
import '../utils/CommonDataUtils.dart';
import '../utils/Dessert.dart';
import './information_history.dart';
import 'dart:ui';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 上次点击时间
  DateTime _lastPressedAt;

  int tabIndex = 0;
  Color color;
  String nickName = "";
  String phone = "";

  List<Map> listOperation = CommonConstant.listOperation;

  List<Map> mainMenu = CommonConstant.mainMenu;
  var bodyHome;
  var pages = <Widget>[
    new InformationPage(),
    new InformationHistory(),
    new DataTableDemo(),
    new SystemConfigurationPage()
  ];

  @override
  initState() {
    super.initState();
    CommonDataUtils.getSysUser().then((sysUser) {
      setState(() {
        nickName = sysUser.nickName;
        phone = sysUser.phone;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> renderMainMenu() {
    List<Widget> menu = [];
    List.generate(this.mainMenu.length, (index) {
      menu.add(
        Expanded(
            child: new GestureDetector(
              behavior: HitTestBehavior.translucent, //
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Icon(mainMenu[index]['icon'],
                        size: 22,
                        color: mainMenu[index]['activeStatus']
                            ? Theme.of(context).primaryColor
                            : CupertinoColors.inactiveGray),
                  ),
                  Text(
                    mainMenu[index]['name'],
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 13,
                        color: mainMenu[index]['activeStatus']
                            ? Theme.of(context).primaryColor
                            : CupertinoColors.inactiveGray),
                  )
                ],
              ),
              onTap: () {
                /// 改变菜单状态
                setState(() {
                  tabIndex = index;

                  /// 改变颜色
                  this.mainMenu.forEach((item) {
                    item['activeStatus'] = false;
                  });
                  mainMenu[index]['activeStatus'] = true;
                });
              },
            ),
            flex: mainMenu[index]['flex']),
      );
    });
    return menu;
  }

  List<Widget> renderPersonOperation() {
    List<Widget> list = [];
    list.add(
      new UserAccountsDrawerHeader(
        accountName: new Text(
          nickName,
          style: TextStyle(fontWeight: FontWeight.w600),
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
        decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
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
            case '个性皮肤':
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new ThemeChangePage();
              })).then((String id) {});
              break;
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    bodyHome = new IndexedStack(
      children: pages,
      index: tabIndex,
    );
    return new WillPopScope(
      child: Scaffold(
          floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 2.0,
            tooltip: '快捷功能',
            onPressed: () {},
            child: new Icon(
              Icons.gps_fixed,
              color: Theme.of(context).primaryColor,
            ),
          ),
          drawer: new Drawer(
            child: Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(),
                  children: this.renderPersonOperation(),
                ),
                new Positioned(
                  child: Container(
                    margin: EdgeInsets.only(bottom: Platform.isIOS ? 34 : 0),
                    height: 50,
                    width: 304,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color(0xffe8e8e8), width: 1))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () => {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.outlined_flag,
                                  size: 18,
                                  color: Color(0xffacacac),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: new Text('夜间模式'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () => {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  size: 18,
                                  color: Color(0xffacacac),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: new Text('设置'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () => {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.fingerprint,
                                  size: 18,
                                  color: Color(0xffacacac),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: new Text('退出'),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  bottom: 0,
                )
              ],
            ),
          ),
          body: bodyHome,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: new Container(
            decoration: new BoxDecoration(
                //设置子控件背后的装饰
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Color(0xfff1f1f1), //阴影颜色
                    blurRadius: 10.0, //阴影大小
                  ),
                ]),
            child: BottomAppBar(
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: this.renderMainMenu(),
                ),
              ),
              shape: CircularNotchedRectangle(),
              color: Colors.white,
            ),
          )),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
    );
  }
}
