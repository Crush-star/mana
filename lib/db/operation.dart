import 'package:manager_system/db/dbHelper.dart';
import 'package:manager_system/typeSet.dart';
import 'package:manager_system/utils/lodash.dart';
import 'package:pluto_grid/pluto_grid.dart';

Future<void> insertProduct(List<Product> productList) async {
  final db = DBHelper();
  final mapList = productList.map((e) => e.toMap()).toList();
  db.insert('products', mapList);
}

Future<void> updateProduct(num id, Product product) async {
  final db = DBHelper();
  final mapValue = product.toMap();
  final pickValue = Lodash.pickBy(mapValue, Lodash.isEmpty);
  await db.update(
    'products',
    pickValue,
    id,
  );
}

Future<List<Map<String, Object?>>> selectProduct({
  bool? distinct,
  List<String>? columns,
  String? where,
  List<Object?>? whereArgs,
  String? groupBy,
  String? having,
  String? orderBy,
  int? limit,
  int? offset,
}) async {
  final db = DBHelper();
  return await db.select(
    'products',
    distinct: distinct,
    columns: columns,
    where: where,
    whereArgs: whereArgs,
    groupBy: groupBy,
    having: having,
    orderBy: orderBy,
    limit: limit,
    offset: offset,
  );
}

Future<List<Map<String, Object?>>> filterProduct(
    {PlutoColumn? sortColumn, List<PlutoRow>? filterRows}) async {

  return await selectProduct(columns: [
    'id',
    'name',
    'count',
    'price',
    'costPrice',
    'alertValue',
    'remark'
  ], 
  // where: '',

  );
}
