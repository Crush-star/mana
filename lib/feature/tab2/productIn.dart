import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:manager_system/a.dart';
import 'package:manager_system/components/inputText.dart';
import 'package:manager_system/components/moveHorizontal.dart';
import 'package:manager_system/feature/tab2/select.dart';
import 'package:manager_system/utils/lodash.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ProductInWidget extends StatefulWidget {
  const ProductInWidget({super.key});

  @override
  State<ProductInWidget> createState() => _ProductInWidgetState();
}

class _ProductInWidgetState extends State<ProductInWidget> {
  int? sortColumnIndex;
  bool sortAscending = true;
  final headTitleMapList = [
    {'title': '序号', 'field': 'id', 'isNumber': true},
    {'title': '名字', 'field': 'name', 'isNumber': false},
    {'title': '数量', 'field': 'count', 'isNumber': true},
    {'title': '单位', 'field': 'unit', 'isNumber': false, 'render': (value) {}},
    {'title': '价钱', 'field': 'price', 'isNumber': false},
    {'title': '成本价', 'field': 'costPrice', 'isNumber': true},
    {'title': '警戒值', 'field': 'alertValue', 'isNumber': true},
    {'title': '备注', 'field': 'remark', 'isNumber': false}
  ];

  List<Map<String, dynamic>> dataRow = [
    {
      'id': 1,
      'name': '罐子_gz',
      'count': 100,
      'unit': '根',
      'price': 20,
      'costPrice': 10,
      'alertValue': 10,
      'remark': '备注',
    },
    {
      'id': 1,
      'name': '罐子_gz',
      'count': 100,
      'unit': '根',
      'price': 20,
      'costPrice': 10,
      'alertValue': 10,
      'remark': '备注',
    },
    {
      'id': 1,
      'name': '罐子_gz',
      'count': 100,
      'unit': '根',
      'price': 20,
      'costPrice': 10,
      'alertValue': 10,
      'remark': '备注',
    },
    {
      'id': 1,
      'name': '罐子_gz',
      'count': 100,
      'unit': '根',
      'price': 20,
      'costPrice': 10,
      'alertValue': 10,
      'remark': '备注',
    },
    {
      'id': 1,
      'name': '罐子_gz',
      'count': 100,
      'unit': '根',
      'price': 20,
      'costPrice': 10,
      'alertValue': 10,
      'remark': '备注',
    },
  ];

  onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  List<DataColumn> getColumns() {
    // return [
    //   DataColumn(
    //       label: Container(alignment: Alignment.centerLeft, child: Text('序号')),
    //       onSort: onSort),
    // ];
    return headTitleMapList
        .map(
          (item) => DataColumn(
            label: Container(
                alignment: Alignment.centerLeft,
                child: Text(item['title'].toString())),
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sortAscending = ascending;
              });
            },
          ),
        )
        .toList();
  }

  updateValue(int row, String field, value) {
    print(value);
    setState(() {
      dataRow[row][field] = value;
    });
  }

  List<DataRow> getRows() {
    return dataRow.asMap().entries.map((entrie) {
      final item = entrie.value;
      final index = entrie.key;
      return DataRow(
          cells: headTitleMapList.map((e) {
        final field = e['field'] as String;
        final isNumber = e['isNumber'] as bool;
        final value = item[field].toString();
        print(value);
        return DataCell(
          Select(
            value: '1',
            options: [
              SelectOption(value: '1', text: '1'),
              SelectOption(value: '2', text: '1'),
              SelectOption(value: '3', text: '1'),
            ],
            onChange: (value) {},
            bottomExtend: Text('123'),
          ),
          //   InputText(
          //   value: value,
          //   isNumber: isNumber,
          //   textOnChanged: (text) {
          //     if (isNumber) {
          //       updateValue(index, field, Lodash.toNumber(text));
          //     } else {
          //       updateValue(index, field, text);
          //     }
          //   },
          // )
        );
      }).toList());
    }).toList();
  }

  addNewRow() {
    setState(() {
      dataRow.add({
        'id': '',
        'name': '',
        'count': '',
        'unit': '',
        'price': '',
        'costPrice': '',
        'alertValue': '',
        'remark': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MoveHorizontalWidget(
      childBuild: (horizontalScrollController) => SizedBox(
        width: 1400,
        child: Column(
          children: [
            Flexible(
              child: DataTable2(
                border: TableBorder.all(
                    color: const Color.fromARGB(128, 204, 204, 204)),
                horizontalScrollController: horizontalScrollController,
                columns: getColumns(),
                rows: getRows(),
                sortAscending: sortAscending,
                sortColumnIndex: sortColumnIndex,
                showBottomBorder: true,
                columnSpacing: 16,
                horizontalMargin: 16,
                minWidth: 1400,
                fixedTopRows: 2,
                sortArrowBuilder: (ascending, sorted) {
                  if (sorted) {
                    return ascending
                        ? Transform.rotate(
                            angle: 3.14159,
                            child: const Icon(
                              Icons.sort,
                              size: 20,
                              color: Colors.green,
                            ),
                          )
                        : const Icon(
                            Icons.sort,
                            size: 20,
                            color: Colors.red,
                          );
                  }
                  return IconButton(onPressed: () {}, icon: Icon(Icons.menu));
                },
              ),
            ),
            IconButton(onPressed: addNewRow, icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
