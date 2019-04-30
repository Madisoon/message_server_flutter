import 'package:flutter/material.dart';

class AddContactInformation extends StatefulWidget {
  AddContactInformation({Key key}) : super(key: key);

  @override
  AddContactInformationState createState() => AddContactInformationState();
}

class AddContactInformationState extends State<AddContactInformation> {
  List<Map> concatType = [
    {
      'name': 'QQ',
      'value': 'qq',
    },
    {
      'name': 'QQ群',
      'value': 'qqGroup',
    },
    {
      'name': '微信',
      'value': 'weixin',
    },
    {
      'name': '微信群',
      'value': 'weixinGroup',
    },
    {
      'name': '手机',
      'value': 'number',
    },
  ];

  TextEditingController numberController = new TextEditingController();

  TextEditingController remarkController = new TextEditingController();

  String selectedValue = 'qq';

  @override
  void initState() {
    super.initState();
  }

  List<Widget> renderCustomerGrade() {
    List<Widget> list = [];
    List.generate(concatType.length, (index) {
      list.add(new Radio(
        value: concatType[index]['name'].toString(),
        groupValue: selectedValue,
        onChanged: (String value) {
          this.setState(() {
            selectedValue = value;
          });
        },
      ));
      list.add(new Text(concatType[index]['name']));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('添加联系方式'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            tooltip: '确认',
            onPressed: () {
              Map map = {
                'number': numberController.text,
                'remark': remarkController.text,
                'type': this.selectedValue
              };
              Navigator.pop(context, map);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: '联系方式'),
            ),
            TextField(
              controller: remarkController,
              decoration: InputDecoration(labelText: '备注'),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: new Text(
                "联系类型",
                style: TextStyle(fontSize: 16),
              ),
            ),
            new Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: List.generate(concatType.length, (index) {
                return ChoiceChip(
                  label: Text(concatType[index]['name'], style: TextStyle()),
                  backgroundColor: Color(0xFFf8f6f2),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        this.selectedValue = concatType[index]['value'];
                      }
                    });
                  },
                  selected: this.selectedValue == concatType[index]['value'],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
