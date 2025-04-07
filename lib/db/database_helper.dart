import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/recetas.dart';
import 'package:intl/intl.dart';

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
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      String path = join(await getDatabasesPath(), 'app_database.db');
      print("Ruta de la base de datos: $path");

      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 2,
          onCreate: _createDB,
          onUpgrade: _upgradeDB,
        ),
      );
    } catch (e) {
      print("Error al inicializar la base de datos: $e");
      rethrow;
    }
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Verificamos si la columna user_id ya existe
      var columns = await db.rawQuery("PRAGMA table_info(recipes)");
      bool hasUserId = columns.any((col) => col['name'] == 'user_id');

      if (!hasUserId) {
        await db.execute("ALTER TABLE recipes ADD COLUMN user_id INTEGER");
        print("Columna 'user_id' añadida a la tabla recipes.");

        // Opcional: añadir restricciones (no se puede hacer con ALTER TABLE fácilmente en SQLite)
      }
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
      print("Tabla users creada correctamente");

      await _createRecipesTable(db);
    } catch (e) {
      print("Error al crear las tablas: $e");
      rethrow;
    }
  }

  Future<void> _createRecipesTable(Database db) async {
    try {
      print("Creando tabla recipes...");
      await db.execute('''
        CREATE TABLE recipes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          description TEXT,
          ingredients TEXT NOT NULL,
          instructions TEXT NOT NULL,
          image_path TEXT,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
        )
      ''');
      print("Tabla recipes creada correctamente");
    } catch (e) {
      print("Error al crear la tabla recipes: $e");
      rethrow;
    }
  }

  // CRUD USUARIOS
  Future<int> insertUser(User user) async {
    try {
      Database db = await database;
      var tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='users'",
      );
      if (tables.isEmpty) {
        print("ERROR: La tabla 'users' no existe");
        return -1;
      }

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
      return List.generate(result.length, (i) => User.fromMap(result[i]));
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

  // CRUD RECETAS
  Future<int> insertRecipe(Recipe recipe) async {
    try {
      Database db = await database;
      var tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='recipes'",
      );
      if (tables.isEmpty) {
        print("ERROR: La tabla 'recipes' no existe");
        return -1;
      }

      int result = await db.insert('recipes', recipe.toMap());
      print("Receta insertada con ID: $result");
      return result;
    } catch (e) {
      print("Error al insertar receta: $e");
      return -1;
    }
  }

  Future<Recipe?> getRecipe(int id) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recipes',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        return Recipe.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print("Error al obtener receta: $e");
      return null;
    }
  }

  Future<List<Recipe>> getAllRecipes() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query('recipes');
      return List.generate(result.length, (i) => Recipe.fromMap(result[i]));
    } catch (e) {
      print("Error al obtener todas las recetas: $e");
      return [];
    }
  }

  Future<List<Recipe>> getRecipesByUser(int userId) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recipes',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      return List.generate(result.length, (i) => Recipe.fromMap(result[i]));
    } catch (e) {
      print("Error al obtener recetas del usuario: $e");
      return [];
    }
  }

  Future<int> updateRecipe(Recipe recipe) async {
    try {
      Database db = await database;
      return await db.update(
        'recipes',
        recipe.toMap(),
        where: 'id = ?',
        whereArgs: [recipe.id],
      );
    } catch (e) {
      print("Error al actualizar receta: $e");
      return -1;
    }
  }

  Future<int> deleteRecipe(int id) async {
    try {
      Database db = await database;
      return await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error al eliminar receta: $e");
      return -1;
    }
  }

  String getCurrentDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  // Buscar recetas por título (nombre)
  Future<List<Recipe>> searchRecipesByTitle(String searchTerm) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recipes',
        where: 'title LIKE ?',
        whereArgs: ['%$searchTerm%'],
        orderBy: 'created_at DESC',
      );
      return List.generate(result.length, (i) => Recipe.fromMap(result[i]));
    } catch (e) {
      print("Error al buscar recetas por título: $e");
      return [];
    }
  }

  // Buscar recetas por ingrediente
  Future<List<Recipe>> searchRecipesByIngredient(String searchTerm) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'recipes',
        where: 'ingredients LIKE ?',
        whereArgs: ['%$searchTerm%'],
        orderBy: 'created_at DESC',
      );
      return List.generate(result.length, (i) => Recipe.fromMap(result[i]));
    } catch (e) {
      print("Error al buscar recetas por ingrediente: $e");
      return [];
    }
  }

  // Método combinado que busca en título e ingredientes
  Future<List<Recipe>> searchRecipes(String searchTerm) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(
        '''
      SELECT * FROM recipes 
      WHERE title LIKE ? OR ingredients LIKE ?
      ORDER BY created_at DESC
    ''',
        ['%$searchTerm%', '%$searchTerm%'],
      );

      return List.generate(result.length, (i) => Recipe.fromMap(result[i]));
    } catch (e) {
      print("Error al buscar recetas: $e");
      return [];
    }
  }
}
