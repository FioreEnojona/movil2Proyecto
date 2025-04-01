import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initDb() async {
  String path = await getDatabasesPath();
  String createTable =
      "CREATE TABLE ${_tableName} (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER NOT NULL, city TEXT NOT NULL, email TEXT NOT NULL)";

  return openDatabase(
    join(path, _dbName),
    onCreate: (database, version) async {
      await database.execute(createTable);
    },
    version: 1,
  );
}

Future<int> insertRecord(SqliteDbModel data) async {
  final Database db = await initDb();
  print(data.toJson());

  // var result = await db.insert(_tableName, data.toJson());
  var result = await db.rawInsert(
    "INSERT INTO ${_tableName} (`name`, `age`, `city`, `email`) VALUES ('${data.name}', ${data.age}, '${data.city}', '${data.email}')",
  );
  return result;
}

Future<List> fetchData() async {
  final Database db = await initDb();
  final List<Map<String, dynamic>> queryResult = await db.query(_tableName);

  // inspect(queryResult);
  return queryResult.map((e) => SqliteDbModel.fromJson(e)).toList();
}
