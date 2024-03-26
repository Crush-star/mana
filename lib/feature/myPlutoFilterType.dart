import 'package:pluto_grid/pluto_grid.dart';

class MyPlutoFilterTypeContains implements PlutoFilterType {
  static String name = '包含';

  @override
  String get title => MyPlutoFilterTypeContains.name;

  @override
  PlutoCompareFunction get compare => FilterHelper.compareContains;

  const MyPlutoFilterTypeContains();
}

class MyPlutoFilterTypeGreaterThan implements PlutoFilterType {
  static String name = '大于';

  @override
  String get title => MyPlutoFilterTypeGreaterThan.name;

  @override
  PlutoCompareFunction get compare => FilterHelper.compareGreaterThan;

  const MyPlutoFilterTypeGreaterThan();
}

class MyPlutoFilterTypeLessThan implements PlutoFilterType {
  static String name = '小于';

  @override
  String get title => MyPlutoFilterTypeLessThan.name;

  @override
  PlutoCompareFunction get compare => FilterHelper.compareLessThan;

  const MyPlutoFilterTypeLessThan();
}
