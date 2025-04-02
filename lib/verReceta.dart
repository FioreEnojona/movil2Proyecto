import 'package:flutter/material.dart';

class VerRecetaPage extends StatelessWidget {
  const VerRecetaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9800),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Ver Receta',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.restaurant_menu, color: Colors.orange, size: 60),
                    SizedBox(height: 8),
                    Text(
                      'Mi Receta Guardada',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoTile(Icons.title, 'Título', 'Tacos de Pollo'),
              const SizedBox(height: 16),
              _buildInfoTile(Icons.description, 'Descripción', 'Una receta rápida y deliciosa para cenar.'),
              const SizedBox(height: 16),
              _buildInfoTile(Icons.shopping_basket, 'Ingredientes', 'Pollo, tortillas, salsa, cebolla, cilantro.'),
              const SizedBox(height: 16),
              _buildInfoTile(Icons.kitchen, 'Preparación',
                  '1. Cocina el pollo\n2. Calienta las tortillas\n3. Mezcla todo'),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción para editar receta
                    // Navigator.push(...);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: const Text(
                    'Editar Receta',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoTile(IconData icon, String title, String content) {
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
