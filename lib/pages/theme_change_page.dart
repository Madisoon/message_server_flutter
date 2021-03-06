import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_event.dart';
import '../constants/CommonConstant.dart';
import '../constants/ThemeConstant.dart';

class ThemeChangePage extends StatefulWidget {
  ThemeChangePage({Key key}) : super(key: key);

  @override
  ThemeChangePageState createState() => ThemeChangePageState();
}

class ThemeChangePageState extends State<ThemeChangePage> {
  @override
  void initState() {
    super.initState();
  }

  changeThemeEventBus(num index) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeIndex", 1);
    CommonConstant.eventBus.fire(new ThemeEvent(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('个性皮肤'),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  '推荐皮肤',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 700,
                child: new GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this would produce 2 rows.
                  crossAxisCount: 3,
                  // 左右间隔
                  crossAxisSpacing: 15.0,
                  // 上下间隔
                  mainAxisSpacing: 10.0,
                  //宽高比
                  childAspectRatio: 2 / 3,
                  // Generate 100 Widgets that display their index in the List
                  children: new List.generate(
                      ThemeConstant.supportColors.length, (index) {
                    return new GestureDetector(
                      onTap: () {
                        /// 更换主题点击事件
                        this.changeThemeEventBus(index);
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                            color: ThemeConstant.supportColors[index],
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
                        child: new Text(
                          'Item $index',
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ));
  }
}
