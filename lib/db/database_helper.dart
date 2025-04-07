import 'package:movil2proyecto/models/otrasrecetas.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/noti.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      // Inicializa FFI en Windows y Linux
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      String path = join(await getDatabasesPath(), 'app_database.db');
      print("Ruta de la base de datos: $path");

      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(version: 1, onCreate: _createDB),
      );
    } catch (e) {
      print("Error al inicializar la base de datos: $e");
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      print("Creando tabla users...");
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL
        )
      ''');

      await db.execute('''
      CREATE TABLE notifications(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
      await db.execute('''
      CREATE TABLE recetas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER,
        titulo TEXT NOT NULL,
        descripcion TEXT,
        ingredientes TEXT NOT NULL,
        preparacion TEXT,
        fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        puntuacion_promedio REAL DEFAULT 0.0,
        FOREIGN KEY (usuario_id) REFERENCES users(id)
      )
    ''');
      print("Tabla users creada correctamente");
    } catch (e) {
      print("Error al crear la tabla users: $e");
      rethrow;
    }
  }

  // Métodos CRUD para usuarios
  Future<int> insertUser(User user) async {
    try {
      Database db = await database;

      // Verificamos si la tabla existe
      var tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='users'",
      );
      if (tables.isEmpty) {
        print("ERROR: La tabla 'users' no existe");
        return -1;
      }

      print("Mapa del usuario a insertar: ${user.toMap()}");
      int result = await db.insert('users', user.toMap());
      print("Usuario insertado con ID: $result");
      return result;
    } catch (e) {
      print("Error al insertar usuario: $e");
      return -1;
    }
  }

  Future<bool> emailExists(String email) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      return result.isNotEmpty;
    } catch (e) {
      print("Error al verificar email: $e");
      return false;
    }
  }

  Future<User?> verifyLogin(String email, String password) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print("Error al verificar login: $e");
      return null;
    }
  }

  Future<User?> getUser(int id) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print("Error al obtener usuario: $e");
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query('users');

      print("Resultados obtenidos: ${result.length}");

      return List.generate(result.length, (i) {
        return User.fromMap(result[i]);
      });
    } catch (e) {
      print("Error al obtener todos los usuarios: $e");
      return [];
    }
  }

  Future<int> updateUser(User user) async {
    try {
      Database db = await database;
      return await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      print("Error al actualizar usuario: $e");
      return -1;
    }
  }

  Future<int> deleteUser(int id) async {
    try {
      Database db = await database;
      return await db.delete('users', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error al eliminar usuario: $e");
      return -1;
    }
  }

  //Notificaciones
  Future<int> insertNoti(Noti noti) async {
    try {
      Database db = await database;
      int result = await db.insert('notifications', noti.toMap());
      print("Notificación insertada con ID: $result");
      return result;
    } catch (e) {
      print("Error al insertar notificación: $e");
      return -1;
    }
  }

  Future<List<Noti>> getAllNotis() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'notifications',
        orderBy: 'created_at DESC',
      );

      print("Notificaciones obtenidas: ${result.length}");

      return List.generate(result.length, (i) {
        return Noti.fromMap(result[i]);
      });
    } catch (e) {
      print("Error al obtener todas las notificaciones: $e");
      return [];
    }
  }

  Future<int> deleteNoti(int id) async {
    try {
      Database db = await database;
      return await db.delete('notifications', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error al eliminar notificación: $e");
      return -1;
    }
  }

  Future<int> deleteAllNotis() async {
    try {
      Database db = await database;
      int count = await db.delete('notifications');
      print("Notificaciones eliminadas: $count");
      return count;
    } catch (e) {
      print("Error al eliminar todas las notificaciones: $e");
      return -1;
    }
  }

  //Otras Recetas
  // Métodos CRUD para OtrasRecetas
  Future<int> insertOtrasRecetas(OtrasRecetas receta) async {
    try {
      Database db = await database;
      print("Mapa de la receta a insertar: ${receta.toMap()}");
      int result = await db.insert('recetas', receta.toMap());
      print("Receta insertada con ID: $result");
      return result;
    } catch (e) {
      print("Error al insertar receta: $e");
      return -1;
    }
  }

  Future<OtrasRecetas?> getOtrasReceta(int id) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recetas',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        return OtrasRecetas.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print("Error al obtener receta: $e");
      return null;
    }
  }

  Future<List<OtrasRecetas>> getAllOtrasRecetas() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recetas',
        orderBy: 'fecha_publicacion DESC',
      );

      print("Recetas obtenidas: ${result.length}");
      return List.generate(result.length, (i) {
        return OtrasRecetas.fromMap(result[i]);
      });
    } catch (e) {
      print("Error al obtener todas las recetas: $e");
      return [];
    }
  }

  Future<int> updateOtrasRecetas(OtrasRecetas receta) async {
    try {
      Database db = await database;
      return await db.update(
        'recetas',
        receta.toMap(),
        where: 'id = ?',
        whereArgs: [receta.id],
      );
    } catch (e) {
      print("Error al actualizar receta: $e");
      return -1;
    }
  }

  Future<int> deleteOtrasRecetas(int id) async {
    try {
      Database db = await database;
      return await db.delete('recetas', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error al eliminar receta: $e");
      return -1;
    }
  }

  // Método adicional para obtener recetas por usuario
  Future<List<OtrasRecetas>> getOtrasRecetasByUser(int usuarioId) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recetas',
        where: 'usuario_id = ?',
        whereArgs: [usuarioId],
        orderBy: 'fecha_publicacion DESC',
      );

      print("Recetas obtenidas para usuario $usuarioId: ${result.length}");
      return List.generate(result.length, (i) {
        return OtrasRecetas.fromMap(result[i]);
      });
    } catch (e) {
      print("Error al obtener recetas por usuario: $e");
      return [];
    }
  }
}
