import 'package:flutter/material.dart';
import 'dart:convert';
import './HomePage.dart';
import '../utils/ApiUtils.dart';
import '../api/api.dart';
import '../utils/CommonDataUtils.dart';

/// 登陆页面
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String userAccount;

  String userPassword;

  @override
  void initState() {
    super.initState();
  }

  userLoginMethod(BuildContext context) async {
    Map<String, String> map = {};
    map['user_loginname'] = userAccount;
    map['user_password'] = userPassword;
    ApiUtils.post(Api.baseUrl + "yuqingmanage/manage/getUserAllInfo",
            params: map)
        .then((rep) {
      Map<String, dynamic> data = json.decode(rep);
      if (data['result'] == 1) {
        CommonDataUtils.saveSysUser(data['data']['user']).then((sysUser) {
          Navigator.pushAndRemoveUntil(
              context,
              new MaterialPageRoute(
                  builder: (context) => new HomePage(title: 'TO YOU')),
              (Route<dynamic> rout) => false);
        });
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('系统通知'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('账号或密码错误，请核对后重新输入'),
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text('知道了'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/login_background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: new Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.all(20),
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: 70,
                    height: 70,
                    child: new Image.asset("lib/images/login_logo.png"),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 40),
                    child: new Text(
                      'To You',
                      style: TextStyle(
                          fontSize: 24, color: Colors.black, letterSpacing: 6),
                    ),
                  ),
                  new Container(
                      alignment: FractionalOffset.centerLeft,
                      margin: EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(left: 22),
                      child: new Row(
                        children: <Widget>[
                          new Text(
                            '随 时 随 地, 用 心 服 务 每 位 客 户',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(0, 0, 0, 0.4)),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.only(left: 22),
                    alignment: Alignment.center,
                    height: 46.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Color(0xfff1f1f1), //阴影颜色
                            blurRadius: 10.0, //阴影大小
                          ),
                        ],
                        borderRadius: new BorderRadius.circular(46.0)),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          onChanged: (String value) {
                            userAccount = value;
                          },
                          decoration: InputDecoration.collapsed(hintText: '账号'),
                        )),
                        new Container(
                          height: 46.0,
                          width: 46.0,
                          child: new Icon(
                            Icons.person,
                            color: Color(0xFF00c1d0),
                            size: 20,
                          ),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                new BoxShadow(
                                  color: Color(0xfff1f1f1), //阴影颜色
                                  blurRadius: 10.0, //阴影大小
                                ),
                              ],
                              borderRadius: new BorderRadius.circular(46)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 22),
                    alignment: Alignment.center,
                    height: 46.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Color(0xfff1f1f1), //阴影颜色
                            blurRadius: 10.0, //阴影大小
                          ),
                        ],
                        borderRadius: new BorderRadius.circular(46.0)),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new TextField(
                          obscureText: true,
                          onChanged: (String value) {
                            userPassword = value;
                          },
                          decoration: InputDecoration.collapsed(hintText: '密码'),
                        )),
                        new Container(
                          height: 46.0,
                          width: 46.0,
                          child: new Icon(
                            Icons.lock_open,
                            color: Color(0xFF00c1d0),
                            size: 20,
                          ),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                new BoxShadow(
                                  color: Color(0xfff1f1f1), //阴影颜色
                                  blurRadius: 10.0, //阴影大小
                                ),
                              ],
                              borderRadius: new BorderRadius.circular(46)),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 24),
                    padding: EdgeInsets.all(5),
                    width: 230,
                    height: 56,
                    decoration: new BoxDecoration(
                      border:
                          new Border.all(width: 1.0, color: Color(0xfff1f1f1)),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(46)),
                    ),
                    child: new FlatButton(
                        child: new Text(
                          "登录",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color(0xFF7a77bd),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(46))),
                        onPressed: () {
                          this.userLoginMethod(context);
                        }),
                  )
                ],
              ),
            ),
          )),
      resizeToAvoidBottomPadding: false,
    );
  }
}
