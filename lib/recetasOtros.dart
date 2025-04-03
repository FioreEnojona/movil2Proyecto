import 'package:flutter/material.dart';

class RecetasOtros extends StatelessWidget {
  const RecetasOtros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool anadida = false; // Simulación de estado local

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9800),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Receta de Otro Usuario', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(Icons.people_alt, size: 60, color: Colors.orange),
                  SizedBox(height: 10),
                  Text(
                    'Pastel de Chocolate',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _infoTile(Icons.description, 'Descripción', 'Pastel suave y esponjoso con cobertura de chocolate.'),
            const SizedBox(height: 16),
            _infoTile(Icons.shopping_cart, 'Ingredientes', 'Harina, cacao, azúcar, huevos, leche, mantequilla.'),
            const SizedBox(height: 16),
            _infoTile(Icons.kitchen, 'Preparación', '1. Mezcla los ingredientes\n2. Hornea a 180°C\n3. Cubre con chocolate.'),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(anadida
                              ? 'Receta eliminada de tus recetas'
                              : 'Receta añadida a tus recetas'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    icon: Icon(anadida ? Icons.remove_circle_outline : Icons.favorite_border),
                    label: Text(anadida ? 'Quitar de mis recetas' : 'Añadir a mis recetas'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  static Widget _infoTile(IconData icon, String title, String content) {
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
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
