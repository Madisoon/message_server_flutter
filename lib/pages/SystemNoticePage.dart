import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SystemNoticePage extends StatefulWidget {
  SystemNoticePage({Key key}) : super(key: key);

  @override
  SystemNoticePageState createState() => SystemNoticePageState();
}

class SystemNoticePageState extends State<SystemNoticePage> {
  bool animate = true;

  @override
  void initState() {
    super.initState();
  }

  Widget chartsRender() {
    var seriesList = _createSampleData();
    return new charts.LineChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearSales(0, 5),
      new LinearSales(1, 5),
      new LinearSales(2, 25),
      new LinearSales(3, 100),
      new LinearSales(4, 75),
      new LinearSales(5, 75),
    ];

    var myFakeTabletData = [
      new LinearSales(0, 5),
      new LinearSales(1, 10),
      new LinearSales(2, 50),
      new LinearSales(3, 200),
      new LinearSales(4, 150),
      new LinearSales(5, 75),
    ];

    var myFakeMobileData = [
      new LinearSales(0, 5),
      new LinearSales(1, 15),
      new LinearSales(2, 75),
      new LinearSales(3, 300),
      new LinearSales(4, 225),
      new LinearSales(5, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('系统通知'),
        backgroundColor: Color(0xFF7a77bd),
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
                    '最近五天记录',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 150,
                  child: chartsRender(),
                )
              ],
            ),
          )),
          Card(
              child: new Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color(0xFF00c1d0), width: 2.6))),
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '新舆情系统',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: new Text(
                                '安徽客户反馈舆情平台漏贴，请查明原因。',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.grey,
                      )
                    ],
                  )),
            ),
          )),
          Card(
              child: new Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Colors.yellow.shade700, width: 2.6))),
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '分拣平台',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: new Text(
                                '信息推送发生错误，无法推送',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.grey,
                      )
                    ],
                  )),
            ),
          )),
          Card(
              child: new Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color(0xFF7a77bd), width: 2.6))),
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '服务平台',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: new Text(
                                '昆山客户即将到期，请及时关注是否续开状态！',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.grey,
                      )
                    ],
                  )),
            ),
          )),
        ],
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
