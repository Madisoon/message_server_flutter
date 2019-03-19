import 'package:flutter/material.dart';

import '../entity/SysInformation.dart';

class InformationDataSource extends DataTableSource {
  List<SysInformation> dataSource = [];

  int _selectedCount = 0;

  void sort<T>(Comparable<T> getField(SysInformation d), bool ascending) {
    dataSource.sort((SysInformation a, SysInformation b) {
      if (!ascending) {
        final SysInformation c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  String subString(String value, int length) {
    return value.length > length ? '${value.substring(0, length)}...' : value;
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= dataSource.length) return null;
    final SysInformation sysInformation = dataSource[index];
    return DataRow.byIndex(
      index: index,
      selected: sysInformation.selected,
      onSelectChanged: (bool value) {
        if (sysInformation.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          sysInformation.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text(
            '${this.subString(sysInformation.title.replaceAll("\n", " "), 30)}')),
        DataCell(Text(
            '${this.subString(sysInformation.content.replaceAll("\n", " "), 100)}')),
        DataCell(Text('${sysInformation.url}')),
        DataCell(Text('${sysInformation.type}')),
        DataCell(Text('${sysInformation.grade}')),
        DataCell(Text('${sysInformation.source}')),
        DataCell(Text('${sysInformation.site}')),
        DataCell(Text('${sysInformation.author}')),
      ],
    );
  }

  @override
  int get rowCount => dataSource.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool checked) {
    for (SysInformation sysInformation in dataSource)
      sysInformation.selected = checked;
    _selectedCount = checked ? dataSource.length : 0;
    notifyListeners();
  }
}
