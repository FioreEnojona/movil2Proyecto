import 'package:flutter/material.dart';
import 'package:movil2proyecto/Busqueda.dart';
import 'package:movil2proyecto/Home_Screen.dart';
import 'package:movil2proyecto/editar_perfil.dart';
import 'package:movil2proyecto/registrar.dart';
import 'package:movil2proyecto/verReceta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/Registrar': (context) => const Registrar(),
        '/Busqueda': (context) => const BusquedaScreen(),
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/Ver_Recetas': (context) => const VerRecetaPage(),
      },
    );
  }
}
