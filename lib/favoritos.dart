import 'package:flutter/material.dart';
import '../models/recetas.dart';
import 'recetas_otro.dart';

// Lista global de favoritos
List<Recipe> recetasFavoritas = [];

class AnadirFavoritos extends StatefulWidget {
  const AnadirFavoritos({super.key});

  @override
  State<AnadirFavoritos> createState() => _AnadirFavoritosState();
}

class _AnadirFavoritosState extends State<AnadirFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Mis Recetas Favoritas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                // Fuerza reconstrucción de la lista
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Lista actualizada"),
                  backgroundColor: Colors.orange,
                ),
              );
            },
          ),
        ],
      ),
      body: recetasFavoritas.isEmpty
          ? const Center(
              child: Text(
                'Aún no has añadido recetas favoritas.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recetasFavoritas.length,
              itemBuilder: (context, index) {
                final receta = recetasFavoritas[index];
                return Card(
                  elevation: 3,
                  shadowColor: Colors.orange.shade200,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: receta.imagePath != null && receta.imagePath!.isNotEmpty
                        ? Image.network(receta.imagePath!, width: 60, height: 60, fit: BoxFit.cover)
                        : const Icon(Icons.food_bank, size: 40, color: Colors.orange),
                    title: Text(
                      receta.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE48826),
                      ),
                    ),
                    subtitle: Text(receta.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recetas_otros(recipe: receta),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
