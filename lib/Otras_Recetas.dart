import 'package:flutter/material.dart';

class OtrasRecetasScreen extends StatelessWidget {
  const OtrasRecetasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas de Otros'),
      ),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Receta Pública ${index + 1}'),
            subtitle: const Text('Descripción breve de la receta.'),
            onTap: () {
              
            },
          );
        },
      ),
    );
  }
}