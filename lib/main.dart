import 'package:flutter/material.dart';
import 'package:movil2proyecto/login.dart';
import 'package:movil2proyecto/menu.dart';
import 'package:movil2proyecto/Home_Screen.dart';
import 'package:movil2proyecto/Busqueda.dart';
import 'package:movil2proyecto/editar_perfil.dart';
import 'package:movil2proyecto/verReceta.dart';
import 'package:movil2proyecto/notificaciones.dart';
import 'package:movil2proyecto/recetasOtros.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/Menu': (context) => const Menu(),
        '/Inicio': (context) => const HomeScreen(),
        '/Busqueda': (context) => const BusquedaScreen(),
        '/Registrar': (context) => const RegisterPage(),
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/Ver_Recetas': (context) => const VerRecetaPage(),
        '/Notificaciones': (context) => const Notificaciones(),
        '/Recetas_Otros': (context) => const RecetasOtros(),
      },
    );
  }
}
