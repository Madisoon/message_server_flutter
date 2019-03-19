import 'package:flutter/material.dart';

import 'dart:convert';

import '../utils/ApiUtils.dart';
import '../utils/InformationDataSource.dart';
import '../entity/SysInformation.dart';

class DifferentTypeInformation extends StatefulWidget {
  DifferentTypeInformation({Key key}) : super(key: key);

  @override
  DifferentTypeInformationState createState() =>
      DifferentTypeInformationState();
}

class DifferentTypeInformationState extends State<DifferentTypeInformation> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  InformationDataSource _informationDataSource = InformationDataSource();

  void _sort<T>(Comparable<T> getField(SysInformation d), int columnIndex,
      bool ascending) {
    _informationDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  setValue(List list) {
    InformationDataSource informationDataSource = InformationDataSource();
    informationDataSource.dataSource = list;
    setState(() {
      this._informationDataSource = informationDataSource;
    });
  }

  @override
  void initState() {
    super.initState();
    this.listInformation();
  }

  void listInformation() {
    Map<String, String> params = {
      'isDelete': "0",
      'isStatus': "1",
      'pageNumber': '1',
      'pageSize': '50',
    };
    ApiUtils.post("http://localhost:8088/manage/listInformation",
            params: params)
        .then((data) {
      if (data != null) {
        // 将接口返回的json字符串解析为map类型
        Map<String, dynamic> map = json.decode(data);
        List listData = map['data'];
        List<SysInformation> listSysInformation = [];
        listData.forEach((item) {
          listSysInformation.add(SysInformation(
              item['infor_title'],
              item['infor_context'],
              item['infor_link'],
              int.parse(item['infor_type']),
              int.parse(item['infor_grade']),
              item['infor_source'],
              item['infor_site'],
              item['infor_author'],
              item['infor_createtime'],
              false));
        });
        this.setValue(listSysInformation);
      }
    });
    // 每页几条，第几页
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          PaginatedDataTable(
            header: const Text('已推送信息'),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              // 每页多少条变化
              setState(() {
                _rowsPerPage = value;
              });
            },
            onPageChanged: (int value) {
              // 页数变化
              print(value);
            },
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            onSelectAll: _informationDataSource.selectAll,
            columns: <DataColumn>[
              DataColumn(
                label: const Text('标题'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (SysInformation d) => d.title, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('内容'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (SysInformation d) => d.content, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('链接'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (SysInformation d) => d.url, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('类型'),
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (SysInformation d) => d.type, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('等级'),
                tooltip: '1，2，3级重要程度依此减少',
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (SysInformation d) => d.grade, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('来源'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (SysInformation d) => d.source, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('站点'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (SysInformation d) => d.site, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text('作者'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (SysInformation d) => d.author, columnIndex, ascending),
              ),
            ],
            source: _informationDataSource,
          ),
        ],
      ),
    );
  }
}
