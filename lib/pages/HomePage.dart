import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/CommonConstant.dart';
import './MessagePostPage.dart';
import './MessageMonitorPage.dart';
import './InformationPage.dart';
import './SystemNoticePage.dart';
import './PersonInformationPage.dart';
import './SystemSettingPage.dart';
import './SystemConfigurationPage.dart';
import './InformationStatisticsPage.dart';
import '../SearchManager.dart';
import '../utils/CommonDataUtils.dart';

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
  int tabIndex = 0;
  Color color;
  String nickName = "";
  String email = "";

  List<Map> listOperation = CommonConstant.listOperation;

  List<Map> mainMenu = CommonConstant.mainMenu;
  var bodyHome;
  var pages = <Widget>[
    new MessagePostPage(),
    new MessageMonitorPage(),
    new InformationPage(),
    new SystemConfigurationPage()
  ];

  @override
  initState() {
    super.initState();
    CommonDataUtils.getSysUser().then((sysUser) {
      setState(() {
        nickName = sysUser.nickName;
        email = sysUser.email;
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
                    child: Icon(mainMenu[index]['icon'],
                        color: mainMenu[index]['activeStatus']
                            ? Color(0xFF7a77bd)
                            : CupertinoColors.inactiveGray),
                    margin: const EdgeInsets.only(bottom: 10.0),
                  ),
                  Text(
                    mainMenu[index]['name'],
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: mainMenu[index]['activeStatus']
                            ? Color(0xFF7a77bd)
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
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        accountEmail: new Text(
          email,
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
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 2.0,
          tooltip: '快捷功能',
          onPressed: () {},
          child: new Icon(
            Icons.gps_fixed,
            color: Color(0xFF7a77bd),
          ),
        ),
        drawer: new Drawer(
          child: ListView(
            padding: const EdgeInsets.only(),
            children: this.renderPersonOperation(),
          ),
        ),
        body: bodyHome,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: new Container(
          decoration: new BoxDecoration(
              //设置子控件背后的装饰
              borderRadius: new BorderRadius.all(Radius.circular(5.0)), //设置圆角
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Color(0xfff1f1f1), //阴影颜色
                  blurRadius: 10.0, //阴影大小
                ),
              ]),
          child: BottomAppBar(
            child: SizedBox(
              height: 65,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: this.renderMainMenu(),
              ),
            ),
            shape: CircularNotchedRectangle(),
            color: Colors.white,
          ),
        ));
  }
}
