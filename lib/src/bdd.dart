import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: avoid_init_to_null
var path = null;

class Bdd {
  Future<Database> opendatabase() async {
    final databasepath = await getDatabasesPath();
    path = join(databasepath, 'database.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tabla(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      version: 1,
    );
  }
}