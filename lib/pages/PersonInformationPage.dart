import 'package:flutter/material.dart';
import '../utils/CommonDataUtils.dart';

/// 个人中心
class PersonInformationPage extends StatefulWidget {
  PersonInformationPage({Key key}) : super(key: key);

  @override
  PersonInformationPageState createState() => PersonInformationPageState();
}

class PersonInformationPageState extends State<PersonInformationPage> {
  String nickName;

  @override
  void initState() {
    super.initState();
    dataInitialization();
  }

  dataInitialization() async {
    CommonDataUtils.getSysUser().then((sysUser) {
      setState(() {
        nickName = sysUser.nickName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('个人中心'),
      ),
      body: new Container(
        color: Colors.grey.shade200,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: <Widget>[
            Card(
                child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            nickName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Row(
                            children: <Widget>[
                              new Text('上元天成信息技术有限公司'),
                              new Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.brightness_auto,
                                  size: 18,
                                  color: Colors.yellow.shade700,
                                ),
                              ),
                            ],
                          ),
                          new Text('软件工程师'),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: new CircleAvatar(
                            backgroundImage:
                                new AssetImage("lib/images/header.jpg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 45),
                    child: Icon(
                      Icons.select_all,
                      color: Color(0xFF7a77bd),
                      size: 30,
                    ),
                  ),
                ],
              ),
            )),
            Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.width - 4) / 2 * 5 / 3 + 4,
                child: GridView.count(
                  //宽高比
                  childAspectRatio: 5 / 3,
                  crossAxisCount: 2,
                  //主轴间隔
                  mainAxisSpacing: 4.0,
                  //横轴间隔
                  crossAxisSpacing: 4.0,
                  children: <Widget>[
                    Card(
                      child: Container(
                        height: (MediaQuery.of(context).size.width - 4) /
                            2 *
                            5 /
                            3 /
                            2,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: new Text(
                                    '入职(天)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.more_horiz,
                                  color: Color(0xFF7a77bd),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: new Text('618',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF7a77bd),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: new Text(
                                  '更多...',
                                  style: TextStyle(color: Color(0xFF7a77bd)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: (MediaQuery.of(context).size.width - 4) /
                            2 *
                            5 /
                            3 /
                            2,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: new Text(
                                    '信息推送(条)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.more_horiz,
                                  color: Color(0xFF7a77bd),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: new Text('86948',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF00c1d0),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: new Text(
                                  '更多...',
                                  style: TextStyle(color: Color(0xFF7a77bd)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: (MediaQuery.of(context).size.width - 4) /
                            2 *
                            5 /
                            3 /
                            2,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '监控信息(条)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: new Text('9806',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF00c1d0),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: new Text(
                                  '更多...',
                                  style: TextStyle(color: Color(0xFF7a77bd)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: (MediaQuery.of(context).size.width - 4) /
                            2 *
                            5 /
                            3 /
                            2,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '报告(份)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: new Text('897',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF7a77bd),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: new Text(
                                  '更多...',
                                  style: TextStyle(color: Color(0xFF7a77bd)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
