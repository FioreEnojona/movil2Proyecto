import 'package:movil2proyecto/database/database_helper.dart';
import 'package:movil2proyecto/model/user_model.dart';

class UserDao {
  // Leer todos los usuarios
  Future<List<UserModel>> readAll() async {
    final db = await DatabaseHelper.instance.database;
    final data = await db.query('users');
    return data.map((e) => UserModel.fromMap(e)).toList();
  }

  // Insertar nuevo usuario
  Future<int> insert(UserModel user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('users', user.toMap());
  }

  // Actualizar usuario existente
  Future<int> update(UserModel user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Eliminar usuario por ID
  Future<int> delete(UserModel user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Validar inicio de sesión (correo + contraseña)
  Future<UserModel?> validarLogin(String name, String password) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'users',
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      return null;
    }
  }
}
