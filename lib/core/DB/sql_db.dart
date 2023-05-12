import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  initDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'test85.db');
    Database mydb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE doctors("id" INTEGER PRIMARY KEY AUTOINCREMENT,"name" TEXT ,"specialist" TEXT ,"phone" TEXT,"email" TEXT)');
    print('===============Created DB Success====================');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql, List values) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql, values);
    return response;
  }

  deleteData(String sql, int id) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql, [id]);
    return response;
  }
}
