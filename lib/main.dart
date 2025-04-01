import 'package:flutter/material.dart';
import 'package:proyectomovil2flutter/Anadir_Receta.dart';
import 'package:proyectomovil2flutter/Busqueda.dart';
import 'package:proyectomovil2flutter/Home_Screen.dart';
import 'package:proyectomovil2flutter/Otras_Recetas.dart';
import 'package:proyectomovil2flutter/editar_perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home_Screen(),
        '/Añadir_Receta': (context) => const AnadirRecetaScreen(),
        '/Busqueda': (context) => const BusquedaScreen(),
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/Otras_Recetas': (context) => const OtrasRecetasScreen(),
      },
    );
  }
}

