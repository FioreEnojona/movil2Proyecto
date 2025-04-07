class Noti {
  final int? id;
  final String title;
  final String message;
  final DateTime? createdAt;
  final int userId; // Foreign key que referencia al usuario

  Noti({
    this.id,
    required this.title,
    required this.message,
    required this.userId, // Ahora es requerido
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'user_id': userId, // Nombre de columna para la FK
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory Noti.fromMap(Map<String, dynamic> map) {
    return Noti(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      userId: map['user_id'], // Mapeo de la FK
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  @override
  String toString() {
    return 'Noti{id: $id, title: $title, message: $message, userId: $userId, createdAt: $createdAt}';
  }
}
