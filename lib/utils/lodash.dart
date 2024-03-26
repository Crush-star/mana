class Lodash {
  static Map<String, dynamic> pickBy(
      Map<String, dynamic> map, bool Function(dynamic) predicate) {
    final result = <String, dynamic>{};
    for (final entry in map.entries) {
      if (predicate(entry.value)) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  static bool isEmpty(v) => v != null && !(v is List && v.isEmpty) && v != '';

  static num toNumber(dynamic value) {
    if (value is int || value is double) {
      return value;
    } else if (value is String) {
      final trimmedValue = value.trim();
      if (RegExp(r'^[-+]?(\d+(\.\d*)?|\.\d+)(e[-+]?\d+)?$')
          .hasMatch(trimmedValue)) {
        return num.parse(trimmedValue);
      }
    }
    return double.nan;
  }
}
