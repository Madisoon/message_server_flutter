import 'package:flutter/material.dart';
import 'dart:convert';
import '../utils/ApiUtils.dart';

import './customer_management_detail.dart';

/// 客户管理
class CustomerManagement extends StatefulWidget {
  CustomerManagement({Key key}) : super(key: key);

  @override
  CustomerManagementState createState() => CustomerManagementState();
}

class CustomerManagementState extends State<CustomerManagement> {
  /// 搜索框状态
  bool searchToolStatus = false;

  /// 数据
  List customerData = [];

  /// 第几页
  num pageNumber = 1;

  /// 每页条数
  num pageSize = 25;

  /// 是否已经获取全部数据
  bool loadingStatus = false;

  /// 是否展示没有数据时的空白页面
  bool emptyPageStatus = false;

  /// 定义滚动控制变量
  ScrollController _scrollController = new ScrollController();

  // 防止下拉过程不断的请求
  bool isPerformingRequest = false;

  /// 搜索的状态条件
  String status = '1';

  /// 搜索关键词条件
  String keyWords = '';

  TextEditingController keyWordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.listMoreCustomer();
      }
    });
    this.listCustomer(true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// clearType=>判断是整
  listCustomer(clearType) {
    if (clearType) {
      this.pageNumber = 1;
    } else {
      this.pageNumber++;
    }
    print(this.pageNumber);
    Map<String, String> params = {
      'pageSize': this.pageSize.toString(),
      'pageNumber': this.pageNumber.toString(),
      'status': this.status,
      'keyWords': this.keyWords,
    };
    ApiUtils.get("http://localhost:8088/manage/listAllCustomer", params: params)
        .then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        setState(() {
          if (clearType) {
            this.customerData = map['data'];
          } else {
            this.customerData.addAll(map['data']);
          }
        });
        if (map['data'] == null || map['data'].length == 0) {
          setState(() {
            loadingStatus = true;
            emptyPageStatus = true;
          });
        } else if (map['data'].length < this.pageSize) {
          setState(() {
            loadingStatus = true;
          });
        } else {
          setState(() {
            loadingStatus = false;
          });
        }
      }
    });
  }

  /// 加载更多，加一页
  listMoreCustomer() {
    this.listCustomer(false);
  }

  searchToolShowOrHide() {
    return this.searchToolStatus
        ? Container(
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 35.0,
                      padding: EdgeInsets.only(left: 17, right: 6),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(35.0)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: new TextField(
                              controller: keyWordController,
                              decoration: InputDecoration.collapsed(
                                  hintText: '输入关键词',
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 14)),
                            ),
                          ),
                          Icon(
                            Icons.clear,
                            color: Colors.grey,
                          )
                        ],
                      )),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    this.keyWords = keyWordController.text;
                    this.listCustomer(true);
                  },
                )
              ],
            ),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  Future<Null> handleRefresh() async {
    // 延迟一秒加载
    await Future.delayed(Duration(seconds: 1), () {
      this.listCustomer(true);
    });
  }

  pageSizeInitialization() {}

  List<Widget> renderCustomer() {
    List<Widget> list = [];
    list.add(this.searchToolShowOrHide());
    this.customerData.forEach((item) {
      list.add(Card(
          child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.push<String>(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new CustomerManagementDetail(
                customerInformation: item,
                pageType: 'update',
              );
            })).then((String id) {});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item['customer_name'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    flex: 1,
                  ),
                  Text(
                    item['customer_status'] == '1' ? '启用' : '停用',
                    style: TextStyle(
                        fontSize: 12,
                        color: item['customer_status'] == '1'
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text('方案:${item['scheme_name']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                    Text('等级:${item['customer_priority']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: this.renderContact(item['get_types'],
                    item['get_numbers'], item['get_remarks']),
              ),
            ],
          ),
        ),
      )));
    });
    list.add(this._buildProgressIndicator());
    return list;
  }

  List<Widget> renderContact(type, number, remark) {
    List<Widget> list = [];
    List typeList = type.toString().split(',');
    List numberList = number.toString().split(',');
    List remarkList = remark.toString().split(',');
    List.generate(typeList.length, (index) {
      if (index == 0 || typeList[index] != typeList[index - 1]) {
        list.add(Divider());
        list.add(Text('${this.typeJudge(typeList[index])}:',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue)));
        list.add(Text('${numberList[index]}(备注：${remarkList[index]})'));
      } else {
        list.add(Text('${numberList[index]}(备注：${remarkList[index]})'));
      }
    });
    return list;
  }

  typeJudge(type) {
    String typeName = '';
    switch (type) {
      case 'number':
        typeName = '手机';
        break;
      case 'qq':
        typeName = 'QQ';
        break;
      case 'qqGroup':
        typeName = 'QQ群';
        break;
      case 'weixin':
        typeName = '微信';
        break;
      case 'weixinGroup':
        typeName = '微信群';
        break;
      default:
        typeName = '未知';
        break;
    }
    return typeName;
  }

  // 加载更多 Widget
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
          child: new Text(
        this.loadingStatus ? '已加载全部数据' : '努力加载中...',
        style: TextStyle(color: Colors.grey),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('客户管理'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '筛选',
            onPressed: () {
              setState(() {
                this.searchToolStatus = !this.searchToolStatus;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            tooltip: '添加',
            onPressed: () {
              var customerObject = {
                'customer_end_time': '',
                'customer_name': '',
                'customer_priority': '',
                'customer_scheme': '',
                'customer_start_time': '',
                'get_numbers': '',
                'get_remarks': '',
                'get_types': '',
                'scheme_name': '',
              };
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new CustomerManagementDetail(
                  customerInformation: customerObject,
                  pageType: 'insert',
                );
              })).then((String id) {});
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              this.status = result;
              this.listCustomer(true);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "",
                    child: Text('全部'),
                  ),
                  const PopupMenuItem<String>(
                    value: "1",
                    child: Text('启用'),
                  ),
                  const PopupMenuItem<String>(
                    value: "0",
                    child: Text('停用'),
                  ),
                ],
          )
        ],
      ),
      body: new RefreshIndicator(
        child: Container(
          child: ListView(
            children: this.renderCustomer(),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
          ),
        ),
        color: Color(0xFF7a77bd),
        onRefresh: handleRefresh,
      ),
    );
  }
}
