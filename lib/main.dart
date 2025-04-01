import 'package:flutter/material.dart';
import 'package:movil2Proyecto/Home_Screen.dart';
import 'package:movil2Proyecto/Añadir_Receta.dart';
import 'package:movil2Proyecto/Búsqueda.dart';
import 'package:movil2Proyecto/editar_perfil.dart';
import 'package:movil2Proyecto/Otras_Recetas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/Añadir_Receta': (context) => const AñadirRecetaScreen(),
        '/Busqueda': (context) => const BusquedaScreen(),
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/Otras_Recetas': (context) => const OtrasRecetasScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 230, 0),
        title: const Text("PROYECTO"),
      ),
      body: const Center(
        child: Text("Grupo 7"),
      ),
    );
  }
}