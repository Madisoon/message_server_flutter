import 'package:flutter/material.dart';

/// 结合floatingActionButtonLocation操作按钮，实现中部按钮凸起的效果的BottomNavigationBar（仿苹果风格）
class FloatingBottomNavigationBar extends StatefulWidget {
  FloatingBottomNavigationBar(this.items, this.onTap, this.currentIndex,
      this.backgroundColor, this.activeColor, this.iconSize, this.border);

  /// 单个元素
  final List<BottomNavigationBarItem> items;

  /// 点击事件
  final ValueChanged<int> onTap;

  /// 现在展示菜单几
  final int currentIndex;

  /// 背景颜色
  final Color backgroundColor;

  /// 选中时的颜色
  final Color activeColor;

  /// 图标大小
  final double iconSize;

  /// 边框
  final Border border;

  @override
  FloatingBottomNavigationBarState createState() =>
      FloatingBottomNavigationBarState();
}

class FloatingBottomNavigationBarState
    extends State<FloatingBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> renderMainMenu() {
    List<Widget> menu = [];
    /*List.generate(this.mainMenu.length, (index) {
      menu.add(
        Expanded(
            child: new GestureDetector(
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
    });*/
    return menu;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}
