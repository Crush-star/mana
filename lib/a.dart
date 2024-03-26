import 'dart:math';

import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:manager_system/components/moveHorizontal.dart';
import 'package:manager_system/components/overlay.dart';
import 'package:manager_system/utils/debounce.dart';

class MyTable extends StatefulWidget {
  const MyTable({Key? key}) : super(key: key);
  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  int? sortColumnIndex;
  bool sortAscending = true;

  final headTitleMapList = [
    {
      'title': '序号',
      'field': 'id',
    },
    {
      'title': '名字',
      'field': 'name',
    },
    {
      'title': '数量',
      'field': 'count',
    },
    {
      'title': '单位',
      'field': 'unit',
    },
    {
      'title': '价钱',
      'field': 'price',
    },
    {
      'title': '成本价',
      'field': 'costPrice',
    },
    {
      'title': '警戒值',
      'field': 'alertValue',
    },
    {
      'title': '备注',
      'field': 'remark',
    }
  ];

  List<Map<String, dynamic>> _data = [
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

  List<DataColumn> getColumns() {
    return headTitleMapList
        .map(
          (item) => DataColumn(
            label: Container(
                width: 400,
                alignment: Alignment.centerLeft,
                child: Text(item['title']!)),
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

  List<DataRow> getRows() {
    final dataList = _data.map((Map<String, dynamic> item) {
      return DataRow(
          cells: headTitleMapList
              .map((e) => DataCell(
                    Text(item[e['field']].toString()),
                  ))
              .toList());
    }).toList();

    return [
      DataRow(
          cells: headTitleMapList
              .map((e) => const DataCell(FilterTextField()))
              .toList()),
      ...dataList
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MoveHorizontalWidget(
      childBuild: (horizontalScrollController) => SizedBox(
        width: 1400,
        child: DataTable2(
          border:
              TableBorder.all(color: const Color.fromARGB(128, 204, 204, 204)),
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
    );
  }
}

class FilterTextField extends StatefulWidget {
  const FilterTextField({Key? key}) : super(key: key);
  @override
  FilterTextFieldState createState() => FilterTextFieldState();
}

class FilterTextFieldState extends State<FilterTextField> {
  bool _hasFocus = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  // OverlayEntry? overlayEntryHandler;
  MyOverlayEntry myOverlayEntry = MyOverlayEntry();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus && myOverlayEntry.hasHandler) {
        removeOverlay();
      }
      setState(() {
        _hasFocus = focusNode.hasFocus;
      });
    });
  }

  textOnChanged(String value) {
    if (value.isNotEmpty) {
      rebuildOverlay(context);
    } else {
      removeOverlay();
    }
  }

  // OverlayEntry buildOverlayEntry() {
  //   return OverlayEntry(builder: (_) {
  //     if (!mounted) return Container();
  //     final value = controller.text;
  //     final RenderBox inputBox = context.findRenderObject() as RenderBox;
  //     final inputPosition = inputBox.localToGlobal(Offset.zero);
  //     return Positioned(
  //       top: inputPosition.dy + inputBox.size.height,
  //       left: inputPosition.dx,
  //       child: Container(
  //         width: inputBox.size.width,
  //         height: 200,
  //         color: Colors.white,
  //         child: OverlaySelectContentWidget(searchText: value),
  //       ),
  //     );
  //   });
  // }

  rebuildOverlay(BuildContext context) {
    if (myOverlayEntry.hasHandler) {
      myOverlayEntry.overlayHandler?.markNeedsBuild();
      return;
    }
    myOverlayEntry.showOverlay(
        context, const OverlaySelectContentWidget(searchText: ''));
  }

  removeOverlay() {
    myOverlayEntry.closeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(
          width: _hasFocus ? 1 : 0.5,
          color: _hasFocus
              ? Colors.blue
              : const Color.fromARGB(202, 185, 185, 185),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          hintText: '包含',
          contentPadding: EdgeInsets.all(10),
          isDense: true,
          hintStyle: TextStyle(fontSize: 14),
          border: InputBorder.none,
        ),
        focusNode: focusNode,
        controller: controller,
        onChanged: textOnChanged,
      ),
    );
  }
}

class OverlaySelectContentWidget extends StatefulWidget {
  final String searchText;
  const OverlaySelectContentWidget({super.key, required this.searchText});

  @override
  State<OverlaySelectContentWidget> createState() =>
      _OverlaySelectContentWidgetState();
}

class _OverlaySelectContentWidgetState
    extends State<OverlaySelectContentWidget> {
  late final Function search;
  @override
  void initState() {
    super.initState();
    search = Debounce.debounce(() {
      print(widget.searchText);
    }, 1000);
    search();
  }

  @override
  void didUpdateWidget(covariant OverlaySelectContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    search();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext _, int index) {});
  }
}
