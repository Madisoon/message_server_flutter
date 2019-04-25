import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../utils/ApiUtils.dart';

class CustomerManagement extends StatefulWidget {
  CustomerManagement({Key key}) : super(key: key);

  @override
  CustomerManagementState createState() => CustomerManagementState();
}

class CustomerManagementState extends State<CustomerManagement> {
  bool searchToolStatus = false;
  List customerData = [];

  num pageNumber = 1;
  num pageSize = 25;
  String status = '';
  String keyWords = '';

  TextEditingController keyWordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.listCustomer();
  }

  listCustomer() {
    Map<String, String> params = {
      'pageSize': this.pageSize.toString(),
      'pageNumber': this.pageNumber.toString(),
      'status': this.status,
      'keyWords': this.keyWords,
    };
    ApiUtils.get("http://localhost:8088/manage/listAllCustomer", params: params)
        .then((data) {
      print(data);
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        setState(() {
          this.customerData = map['data'];
        });
      }
    });
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
                    this.listCustomer();
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
    this.pageNumber = 1;
    await Future.delayed(Duration(seconds: 1), () {
      this.listCustomer();
    });
  }

  List<Widget> renderCustomer() {
    List<Widget> list = [];
    list.add(this.searchToolShowOrHide());
    this.customerData.forEach((item) {
      list.add(Card(
          child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {},
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
        list.add(Text('${typeList[index]}:',
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

  // 加载更多 Widget
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
          child: new Text(
            true ? '已加载全部数据' : '努力加载中...',
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
          PopupMenuButton<String>(
            onSelected: (String result) {
              this.status = result;
              this.listCustomer();
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
          ),
        ),
        color: Color(0xFF7a77bd),
        onRefresh: handleRefresh,
      ),
    );
  }
}
