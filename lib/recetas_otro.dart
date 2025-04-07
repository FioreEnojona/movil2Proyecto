import 'package:flutter/material.dart';
import '../models/recetas.dart';

class Recetas_otros extends StatefulWidget {
  final Recipe recipe;

  const Recetas_otros({Key? key, required this.recipe}) : super(key: key);

  @override
  _Recetas_otrosState createState() => _Recetas_otrosState();
}

class _Recetas_otrosState extends State<Recetas_otros> {
  bool anadida = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9800),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.recipe.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  widget.recipe.imagePath != null &&
                          widget.recipe.imagePath!.isNotEmpty
                      ? Image.network(
                        widget.recipe.imagePath!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      )
                      : const Icon(
                        Icons.people_alt,
                        size: 60,
                        color: Colors.orange,
                      ),
                  const SizedBox(height: 10),
                  Text(
                    widget.recipe.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _infoTile(
              Icons.description,
              'Descripción',
              widget.recipe.description.isNotEmpty
                  ? widget.recipe.description
                  : 'No hay descripción disponible',
            ),
            const SizedBox(height: 16),
            _infoTile(
              Icons.shopping_cart,
              'Ingredientes',
              widget.recipe.ingredients,
            ),
            const SizedBox(height: 16),
            _infoTile(Icons.kitchen, 'Preparación', widget.recipe.instructions),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        anadida = !anadida;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            anadida
                                ? 'Receta añadida a tus recetas'
                                : 'Receta eliminada de tus recetas',
                          ),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    icon: Icon(
                      anadida ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    label: Text(
                      anadida
                          ? 'Quitar de mis recetas'
                          : 'Añadir a mis recetas',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
