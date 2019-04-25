import 'package:flutter/material.dart';

/// 客户管理搜索
class CustomerManagementSearch extends StatefulWidget {
  CustomerManagementSearch({Key key}) : super(key: key);

  @override
  CustomerManagementSearchState createState() =>
      CustomerManagementSearchState();
}

class CustomerManagementSearchState extends State<CustomerManagementSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: '请输入关键词'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '筛选',
            onPressed: () {
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return CustomerManagementSearch();
              })).then((String id) {});
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
