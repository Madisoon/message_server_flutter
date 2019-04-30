import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_server_flutter/api/api.dart';
import 'dart:convert';

import '../utils/ApiUtils.dart';
import '../utils/CommonOperation.dart';
import 'add_contact_information.dart';
import 'select_program.dart';
// 可能需要走两套逻辑，添加逻辑和修改逻辑

@immutable
class CustomerManagementDetail extends StatefulWidget {
  /// 客户类型
  var customerInformation;

  /// 操作类型（新增 or 删除）
  var pageType;

  CustomerManagementDetail({Key key, this.customerInformation, this.pageType})
      : super(key: key);

  @override
  CustomerManagementDetailState createState() =>
      CustomerManagementDetailState();
}

class CustomerManagementDetailState extends State<CustomerManagementDetail> {
  /// 标题输入控制器
  TextEditingController titleController = new TextEditingController();

  /// 联系人数据
  List<Map> contactData = [];

  /// 内容输入控制器
  TextEditingController remarkController;

  String startTime = '';
  String endTime = '';

  @override
  void initState() {
    super.initState();
    List<Map> data = [];
    titleController.text = widget.customerInformation['customer_name'];
    List typeList = widget.customerInformation['get_types'].toString() != ''
        ? widget.customerInformation['get_types'].toString().split(',')
        : [];
    List numberList =
        widget.customerInformation['get_numbers'].toString().split(',');
    List remarkList =
        widget.customerInformation['get_remarks'].toString().split(',');
    List.generate(typeList.length, (index) {
      Map map = {
        'number': numberList[index],
        'remark': remarkList[index],
        'type': typeList[index]
      };
      data.add(map);
    });
    setState(() {
      this.contactData = data;
    });
  }

  _showDatePicker(type) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),

            /// 最早开始时间
            firstDate: DateTime.parse('2018-01-01'),

            /// 最迟结束时间
            lastDate: DateTime.parse('2025-12-31'))
        .then((value) {
      setState(() {
        if (type == 'start') {
          startTime = value.toString().substring(0, 10);
        } else {
          endTime = value.toString().substring(0, 10);
        }
      });
    });
  }

  /// 管理客户（包括新增和修改两个操作）
  saveCustomerData() {
    Map customerData = {
      'customer_name': widget.customerInformation['customer_name'],
      'customer_start_time': this.startTime,
      'customer_end_time': this.endTime,
      'customer_priority': widget.customerInformation['customer_priority'],
      'customer_scheme': widget.customerInformation['customer_scheme'],
    };
    List list = [];
    this.contactData.forEach((item) {
      list.add({
        "get_number": item['number'],
        "get_remark": item['number'],
        "get_type": item['type']
      });
    });

    Map<String, String> params = {
      'customerData': jsonEncode(customerData),
      'getData': jsonEncode(list),
    };

    if (widget.pageType == 'update') {
      /// 修改
      params['serveCustomerId'] = widget.customerInformation['id'];
      ApiUtils.post(Api.baseUrl + "yuqingmanage/manage/updateServeCustomer",
              params: params)
          .then((data) {
        if (data != null) {
          Map<String, dynamic> map = json.decode(data);
          Navigator.pop(context);
        }
      });
    } else {
      /// 插入
      params['areaId'] = '29';
      ApiUtils.post(Api.baseUrl + "yuqingmanage/manage/insertServeCustomer",
              params: params)
          .then((data) {
        if (data != null) {
          Map<String, dynamic> map = json.decode(data);
          Navigator.pop(context);
        }
      });
    }
  }

  List<Widget> renderCustomerGrade() {
    List<Widget> list = [];
    list.add(new Text("优先级"));
    List.generate(3, (index) {
      list.add(new Radio(
        value: '${index + 1}',
        groupValue: widget.customerInformation['customer_priority'].toString(),
        onChanged: (String value) {
          this.setState(() {
            widget.customerInformation['customer_priority'] = value;
          });
        },
      ));
      list.add(new Text(
        "${index + 1}级",
        style: TextStyle(color: Colors.grey),
      ));
    });
    return list;
  }

  List<Widget> renderConcatData() {
    List<Widget> list = [];

    /// 只分三种类型，qq，微信，手机  // 不再区分qq号还是qq群
    this.contactData.forEach((item) {
      list.add(ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage:
                new AssetImage(CommonOperation.typeJudge(item['type'])['icon']),
          ),
          title: Text('${item['number']}'),
          subtitle: Text('${item['remark']}'),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                this
                    .contactData
                    .removeWhere((data) => data['number'] == item['number']);
              });
            },
            child: Icon(Icons.clear),
          )));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('客户详情'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              this.saveCustomerData();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 6, right: 6, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: titleController,
              onChanged: (value) {
                widget.customerInformation['customer_name'] = value;
              },
              decoration: InputDecoration(labelText: '客户名称'),
            ),
            new Row(
              children: this.renderCustomerGrade(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                '生效时间',
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 32.0,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Color(0xfff1f1f1), //阴影颜色
                              blurRadius: 10.0, //阴影大小
                            ),
                          ],
                          borderRadius: new BorderRadius.circular(32.0)),
                      child: Text(
                        this.startTime != '' ? this.startTime : '请选择',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      this._showDatePicker('start');
                    },
                  ),
                  flex: 1,
                ),
                Container(
                  child: Text('至'),
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 32.0,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Color(0xfff1f1f1), //阴影颜色
                              blurRadius: 10.0, //阴影大小
                            ),
                          ],
                          borderRadius: new BorderRadius.circular(32.0)),
                      child: Text(
                        this.endTime != '' ? this.endTime : '请选择',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      this._showDatePicker('end');
                    },
                  ),
                  flex: 1,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '方案',
                    ),
                    flex: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<Map>(context, new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return new SelectProgram();
                      })).then((Map data) {
                        if (data != null && data['name'] != null) {
                          setState(() {
                            widget.customerInformation['scheme_name'] =
                                data['name'];
                            widget.customerInformation['customer_scheme'] =
                                data['id'];
                          });
                        }
                      });
                    },
                    child: Text(
                      widget.customerInformation['scheme_name'] != ''
                          ? widget.customerInformation['scheme_name']
                          : '请选择',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '接收方式',
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey.shade400,
                  ),
                  onPressed: () {
                    Navigator.push<Map>(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new AddContactInformation();
                    })).then((Map data) {
                      if (data != null) {
                        // 添加了一个联系方式
                        setState(() {
                          this.contactData.add(data);
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            Column(
              children: this.renderConcatData(),
            )
          ],
        ),
      ),
    );
  }
}
