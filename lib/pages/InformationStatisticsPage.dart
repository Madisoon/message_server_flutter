import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../utils/ApiUtils.dart';
import 'dart:convert';

/// 信息统计页面
class InformationStatisticsPage extends StatefulWidget {
  InformationStatisticsPage({Key key}) : super(key: key);

  @override
  InformationStatisticsPageState createState() =>
      InformationStatisticsPageState();
}

class InformationStatisticsPageState extends State<InformationStatisticsPage> {
  List<OrdinalSales> dataChart = [];

  @override
  void initState() {
    super.initState();
  }

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    ApiUtils.get("http://114.115.253.92:8080/yuqingmanage/manage/getTodayRank")
        .then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        var informationData = map['data'];
        List<OrdinalSales> dataTemporary = [];
        informationData.forEach((item) {
          dataTemporary.add(new OrdinalSales(
              item['infor_createtime'].toString().substring(5, 10),
              int.parse(item['total'])));
        });

        setState(() {
          dataChart = dataTemporary;
        });
      }
    });

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'information',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: dataChart,
      )
    ];
  }

  Widget chartsRender() {
    var seriesList = _createSampleData();
    return new charts.BarChart(
      seriesList,
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('统计'),
        backgroundColor: Color(0xFF7a77bd),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "1",
                    child: Text('本周'),
                  ),
                  const PopupMenuItem<String>(
                    value: "2",
                    child: Text('本月'),
                  ),
                  const PopupMenuItem<String>(
                    value: "3",
                    child: Text('本年'),
                  ),
                ],
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
              child: new Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                new Align(
                  alignment: Alignment.topLeft,
                  child: new Text(
                    '推送信息类型比例',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 150,
                  child: this.chartsRender(),
                )
              ],
            ),
          )),
          Card(
              child: new Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                new Align(
                  alignment: Alignment.topLeft,
                  child: new Text(
                    '信息记录',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 150,
                  child: this.chartsRender(),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
