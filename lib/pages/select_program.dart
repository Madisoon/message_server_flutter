import 'package:flutter/material.dart';
import 'dart:convert';

import '../utils/ApiUtils.dart';

class SelectProgram extends StatefulWidget {
  SelectProgram({Key key}) : super(key: key);

  @override
  SelectProgramState createState() => SelectProgramState();
}

class SelectProgramState extends State<SelectProgram> {
  List schemeData = [];
  Map map = {'id': '', 'name': ''};
  TextEditingController keyWordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  listScheme(keyWord) {
    ApiUtils.get("http://localhost:8088/manage/getSchemeByKeyWord",
        params: {'keyWord': keyWord}).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        setState(() {
          schemeData = map['data'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: TextField(
          controller: keyWordController,
          onSubmitted: (String value) {
            this.listScheme(value);
          },
          decoration: InputDecoration(
              hintText: '请输入关键字',
              suffixIcon: InkWell(
                onTap: () {
                  this.map['id'] = '';
                  this.map['name'] = '';
                  keyWordController.text = '';
                  setState(() {
                    this.schemeData = [];
                  });
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, this.map);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 4, top: 25),
              child: Text(
                '搜索结果',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  new Wrap(
                    spacing: 6.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: List.generate(schemeData.length, (index) {
                      return ChoiceChip(
                        label: Text('${schemeData[index]['scheme_name']}',
                            style: TextStyle()),
                        backgroundColor: Colors.grey.shade400,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onSelected: (bool value) {
                          setState(() {
                            if (value) {
                              this.map['id'] = schemeData[index]['id'];
                              this.map['name'] =
                                  schemeData[index]['scheme_name'];
                            }
                          });
                        },
                        selected: this.map['id'] == schemeData[index]['id'],
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
