class UserModel {
  final int? id;
  final String name; // correo
  final String password;

  UserModel({this.id, required this.name, required this.password});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'password': password,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        name: map['name'],
        password: map['password'],
      );
}
