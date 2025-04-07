// models/user.dart
class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  // Convertir User a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password':
          password, // Nota: en producción, deberías cifrar las contraseñas
    };
  }

  // Crear User desde Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }
}
