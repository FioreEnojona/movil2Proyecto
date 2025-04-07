// models/recipe.dart
class Recipe {
  int? id;
  int userId;
  String title;
  String description;
  String ingredients;
  String instructions;
  String? imagePath;
  String createdAt;

  Recipe({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    this.imagePath,
    required this.createdAt,
  });

  // Convertir Recipe a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'image_path': imagePath,
      'created_at': createdAt,
    };
  }

  // Crear Recipe desde Map
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      ingredients: map['ingredients'],
      instructions: map['instructions'],
      imagePath: map['image_path'],
      createdAt: map['created_at'],
    );
  }

  // Para debugging
  @override
  String toString() {
    return 'Recipe{id: $id, userId: $userId, title: $title, description: $description}';
  }

  
}