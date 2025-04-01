import 'package:flutter/material.dart';

class BusquedaScreen extends StatelessWidget {
  const BusquedaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Recetas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Buscar...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Receta ${index + 1}'),
                    onTap: () {
                      
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}