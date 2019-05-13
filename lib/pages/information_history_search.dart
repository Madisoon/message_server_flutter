import 'package:flutter/material.dart';

class InformationHistorySearch extends StatefulWidget {
  InformationHistorySearch({Key key}) : super(key: key);

  @override
  InformationHistorySearchState createState() =>
      InformationHistorySearchState();
}

class InformationHistorySearchState extends State<InformationHistorySearch> {
  /// 焦点兼听监听事件
  FocusNode _focusNode = FocusNode();

  TextEditingController keyWordController = new TextEditingController();

  String startTime = '请选择';

  String endTime = '请选择';

  bool clearStatus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // TextField has lost focus
        setState(() {
          this.clearStatus = true;
        });
      } else {
        setState(() {
          this.clearStatus = false;
        });
      }
    });
  }

  _showDatePicker(type) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),

            /// 最早开始时间
            firstDate: DateTime.parse('2018-01-01'),

            /// 最迟结束时间
            lastDate: DateTime.now())
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

  backInformationList() {
    /// 搜索参数
    Map map = {
      'startTime': this.startTime == '请选择' ? '' : this.startTime,
      'endTime': this.endTime == '请选择' ? '' : this.endTime,
      'keyWord': keyWordController.text
    };
    Navigator.pop(context, map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 17.5, right: 10),
              height: 35.0,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(35.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: new TextField(
                      controller: keyWordController,
                      focusNode: _focusNode,
                      onSubmitted: (value) {
                        this.backInformationList();
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: '输入关键词',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade300, fontSize: 14)),
                    ),
                  ),
                  this.clearStatus
                      ? InkWell(
                          onTap: () {
                            keyWordController.text = '';
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey.shade400,
                          ),
                        )
                      : Container(),
                ],
              )),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          this._showDatePicker('start');
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: new Text('开始时间',
                                    style: TextStyle(fontSize: 16)),
                              ),
                              new Text(
                                this.startTime,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          this._showDatePicker('end');
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: new Text('结束时间',
                                    style: TextStyle(fontSize: 16)),
                              ),
                              new Text(
                                this.endTime,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            this.backInformationList();
                          },
                          color: Color(0xFF7a77bd),
                          child: new Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              '确定',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
