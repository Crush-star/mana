import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manager_system/db/operation.dart';
import 'package:manager_system/feature/myPlutoFilterType.dart';
import 'package:manager_system/typeSet.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final PlutoGridStateManager stateManager;
  final List<PlutoRow> rows = [];

  final visibilityList = <int>[];
  setVisibility({
    required int index,
  }) {
    setState(() {
      visibilityList.add(index);
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (visibilityList.contains(index)) {
        setState(() {
          visibilityList.remove(index);
        });
      }
    });
  }

  void showOverlay(BuildContext context, Offset position) {
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  void initState() {
    super.initState();
    rows.addAll([
      PlutoRow(
        cells: {
          'id': PlutoCell(value: 1),
          'name': PlutoCell(value: 'qq啊等等的长哦吃滴啊鹅奖拉颤抖辣椒粉蠢哦嗯车翻了几分来拆弹了罐子_gz'),
          'count': PlutoCell(value: 100),
          'unit': PlutoCell(value: '根'),
          'price': PlutoCell(value: 20),
          'costPrice': PlutoCell(value: 10),
          'alertValue': PlutoCell(value: 10),
          'remark': PlutoCell(value: '备注'),
        },
      ),
      PlutoRow(
        cells: {
          'id': PlutoCell(value: 1),
          'name': PlutoCell(value: '罐子_gz'),
          'count': PlutoCell(value: 100),
          'unit': PlutoCell(value: '根'),
          'price': PlutoCell(value: 20),
          'costPrice': PlutoCell(value: 10),
          'alertValue': PlutoCell(value: 10),
          'remark': PlutoCell(value: '备注'),
        },
      )
    ]);
  }

  // void _handleFilterChange() {
  //   if (stateManager.hasFilter) {
  //     print(stateManager.filterRows[0].cells['column']?.value);
  //     print(stateManager.filterRows[0].cells['value']?.value);
  //     print(stateManager.filterRows[0].cells['type']?.value is MyPlutoFilterTypeContains);
  //     a = stateManager.filterRows;
  //     // print("Check here ");
  //   }
  // }

  // Future<PlutoLazyPaginationResponse> fetch(
  //   PlutoLazyPaginationRequest request,
  // ) async {
  //   print(request.sortColumn?.field);
  //   print(request.sortColumn?.sort);
  //   print('len:${request.filterRows.length}');

  //   final c = FilterHelper.convertRowsToMap(request.filterRows);
  //   print('c:$c');

  //   final filter = FilterHelper.convertRowsToFilter(
  //     request.filterRows,
  //     stateManager.refColumns,
  //   );

  //   print('filter:$filter');

  //   // final res = filterProduct();
  //   // print(res);
  //   await Future.delayed(const Duration(milliseconds: 500));

  //   return Future.value(PlutoLazyPaginationResponse(
  //     totalPage: 1,
  //     rows: [
  //       PlutoRow(
  //         cells: {
  //           'id': PlutoCell(value: 1),
  //           'name': PlutoCell(value: '罐子'),
  //           'count': PlutoCell(value: 100),
  //           'price': PlutoCell(value: 20),
  //           'costPrice': PlutoCell(value: 10),
  //           'alertValue': PlutoCell(value: 10),
  //           'remark': PlutoCell(value: '备注'),
  //         },
  //       ),
  //     ],
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: [
        PlutoColumn(
          title: '序号',
          field: 'id',
          width: 80,
          type: PlutoColumnType.text(),
          // readOnly: false,
          // enableEditingMode: false,
          // enableSetColumnsMenuItem: false,
          // enableHideColumnMenuItem: false,
          // enableDropToResize: false,
          // enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '名字',
          field: 'name',
          type: PlutoColumnType.text(),
          renderer: (rendererContext) {
            final value = rendererContext.cell.value.toString();
            final name = value.split('_').first;
            return Text(name);
          },
          // readOnly: false,
          // enableEditingMode: false,
          // enableSetColumnsMenuItem: false,
          // enableHideColumnMenuItem: false,
          // enableDropToResize: false,
          // enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '数量',
          field: 'count',
          type: PlutoColumnType.number(),
          readOnly: false,
          enableEditingMode: false,
          enableSetColumnsMenuItem: false,
          enableHideColumnMenuItem: false,
          enableDropToResize: false,
          enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '单位',
          field: 'unit',
          type: PlutoColumnType.text(),
          readOnly: false,
          enableEditingMode: false,
          enableSetColumnsMenuItem: false,
          enableHideColumnMenuItem: false,
          enableDropToResize: false,
          enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '价钱',
          field: 'price',
          type: PlutoColumnType.number(),
          renderer: (rendererContext) {
            return AutocompleteTextField(
              options: ['啊', '把', '错'],
            );
            return TextField();
          },
          readOnly: true,
          enableEditingMode: false,
          enableSetColumnsMenuItem: false,
          enableHideColumnMenuItem: false,
          enableDropToResize: false,
          enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '成本价',
          field: 'costPrice',
          type: PlutoColumnType.text(),
          renderer: (rendererContext) {
            final value = rendererContext.cell.value.toString();
            final index = rendererContext.rowIdx;
            if (!visibilityList.contains(index)) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('***'),
                  IconButton(
                      onPressed: () {
                        setVisibility(index: index);
                      },
                      icon: const Icon(Icons.visibility_outlined))
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                IconButton(
                    onPressed: () {
                      setState(() {
                        visibilityList.remove(index);
                      });
                    },
                    icon: const Icon(Icons.visibility_off_outlined))
              ],
            );
          },
          readOnly: false,
          enableEditingMode: false,
          enableSetColumnsMenuItem: false,
          enableHideColumnMenuItem: false,
          enableDropToResize: false,
          enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '警戒值',
          field: 'alertValue',
          type: PlutoColumnType.number(),
          readOnly: false,
          enableEditingMode: false,
          enableSetColumnsMenuItem: false,
          enableHideColumnMenuItem: false,
          enableDropToResize: false,
          enableColumnDrag: false,
        ),
        PlutoColumn(
          title: '备注',
          field: 'remark',
          type: PlutoColumnType.text(),
          readOnly: false,
          enableEditingMode: false,
          enableSetColumnsMenuItem: false,
          enableHideColumnMenuItem: false,
          enableDropToResize: false,
          enableColumnDrag: false,
        ),
      ],
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {},
      // onSorted: (event) {
      //   // print(event.column.field);
      //   // print(event.column.sort);
      // },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        event.stateManager.setShowColumnFilter(true);
        // event.stateManager.addListener(_handleFilterChange);
      },
      configuration: PlutoGridConfiguration(
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [
            MyPlutoFilterTypeContains(),
            MyPlutoFilterTypeGreaterThan(),
            MyPlutoFilterTypeLessThan(),
          ],
          resolveDefaultColumnFilter: (column, resolver) {
            return resolver<MyPlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),

      // createFooter: (stateManager) {
      //   return PlutoLazyPagination(
      //     initialPage: 1,
      //     initialFetch: true,
      //     fetchWithSorting: true,
      //     fetchWithFiltering: true,
      //     pageSizeToMove: null,
      //     fetch: fetch,
      //     stateManager: stateManager,
      //   );
      // },
    );
  }
}

class AutocompleteTextField extends StatefulWidget {
  final List<String> options;
  AutocompleteTextField({required this.options});
  @override
  _AutocompleteTextFieldState createState() => _AutocompleteTextFieldState();
}

class _AutocompleteTextFieldState extends State<AutocompleteTextField> {
  final TextEditingController _textController = TextEditingController();
  bool _showOptions = false;
  List<String> _filteredOptions = [];
  GlobalKey globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      print('object');
      setState(() {
        _filteredOptions = widget.options
            .where((option) => option
                .toLowerCase()
                .contains(_textController.text.toLowerCase()))
            .toList();
        _showOptions = _filteredOptions.isNotEmpty;
      });
    });
    _textController.value = TextEditingValue(text: 'value');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: (value) {
        print('valie$value');
        _textController.value = TextEditingValue(text: value);
      },
      decoration: InputDecoration(
          // hintText: 'Search...',
          ),
      onTap: () {
        // final rendObj =
        //     globalKey.currentContext?.findRenderObject() as RenderBox;
        // final position = rendObj?.localToGlobal(Offset.zero);
        // print('rendObj${position}');
        // final height = globalKey.currentContext?.size?.height;
        // final width = globalKey.currentContext?.size?.width;

        final con = context.findRenderObject() as RenderBox;
        final position1 = con.localToGlobal(Offset.zero);
        print('con:$position1::${con.size}');
      },
    );
  }
}
