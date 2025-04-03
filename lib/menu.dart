import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 230, 0),
        title: const Text("PROYECTO"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Inicio');
            },
            child: const Text('Pagina Principal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Registrar');
            },
            child: const Text('Añadir Receta'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Busqueda');
            },
            child: const Text('Buscar Recetas'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/editar_perfil');
            },
            child: const Text('Editar Perfil'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Ver_Recetas');
            },
            child: const Text('Ver Recetas'),
          ),
        ],
      ),
    );
  }
}
