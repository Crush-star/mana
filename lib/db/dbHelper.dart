import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHelper {
  Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'product_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, 
            pinyin TEXT, count INTEGER, price TEXT,costPrice INTEGER,productIn TEXT, 
            productOut TEXT, alertValue INTEGER, remark TEXT)''');
        await db.execute(
            'CREATE TABLE sale (id INTEGER PRIMARY KEY, customer TEXT, productDetails TEXT, remark TEXT)');
      },
    );
  }

  // Future<void> exportDatabase(Database database) async {
  //   String path = join(await getDatabasesPath(), 'product_database.db');
  //   await database.close();
  //   await File(path).writeAsBytes(await File(database.path).readAsBytes());
  // }

  Future<void> insert(String table, List<Map<String, Object?>> mapList) async {
    final db = await createDatabase();
    final batch = db.batch();
    for (final map in mapList) {
      batch.insert(
        table,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  Future<List<Map<String, Object?>>> select(
    String table, {
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
    final db = await createDatabase();
    final result = await db.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: groupBy,
        orderBy: groupBy,
        limit: limit,
        offset: limit);
    db.close();
    return result;
  }

  Future<void> update(String table, Map<String, Object?> map, num id) async {
    final db = await createDatabase();
    await db.update(
      table,
      map,
      where: 'id = ?',
      whereArgs: [id],
    );
    db.close();
  }

  Future<void> delete(String table, int id) async {
    final db = await createDatabase();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    db.close();
  }

  // Future<void> exportDatabaseToFile() async {
  //   final db = await createDatabase();
  //   await exportDatabase(db);
  // }
}
