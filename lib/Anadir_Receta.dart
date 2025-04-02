import 'package:flutter/material.dart';

class AnadirRecetaScreen extends StatelessWidget {
  const AnadirRecetaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nombre de la receta:'),
            const TextField(),
            const SizedBox(height: 20),
            const Text('Descripción:'),
            const TextField(
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}