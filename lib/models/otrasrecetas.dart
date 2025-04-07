// models/otrasrecetas.dart
class OtrasRecetas {
  final int? id;
  final int usuarioId;
  final String titulo;
  final String? descripcion;
  final String ingredientes;
  final String? preparacion;
  final DateTime fechaPublicacion;
  final double puntuacionPromedio;

  OtrasRecetas({
    this.id,
    required this.usuarioId,
    required this.titulo,
    this.descripcion,
    required this.ingredientes,
    this.preparacion,
    DateTime? fechaPublicacion,
    this.puntuacionPromedio = 0.0,
  }) : fechaPublicacion = fechaPublicacion ?? DateTime.now();

  // Convertir OtrasRecetas a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'titulo': titulo,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'preparacion': preparacion,
      'fecha_publicacion': fechaPublicacion.toIso8601String(),
      'puntuacion_promedio': puntuacionPromedio,
    };
  }

  // Crear OtrasRecetas desde Map
  factory OtrasRecetas.fromMap(Map<String, dynamic> map) {
    return OtrasRecetas(
      id: map['id'],
      usuarioId: map['usuario_id'],
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      ingredientes: map['ingredientes'],
      preparacion: map['preparacion'],
      fechaPublicacion: DateTime.parse(map['fecha_publicacion']),
      puntuacionPromedio: map['puntuacion_promedio']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'OtrasRecetas{id: $id, usuarioId: $usuarioId, titulo: $titulo}';
  }
}
