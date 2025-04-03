import 'package:flutter/material.dart';
import 'package:movil2proyecto/login.dart';
import 'package:movil2proyecto/Home_Screen.dart';
import 'package:movil2proyecto/editar_perfil.dart';
import 'package:movil2proyecto/verReceta.dart';
import 'package:movil2proyecto/registrar.dart';
import 'package:movil2proyecto/notificaciones.dart';
import 'package:movil2proyecto/Busqueda.dart';
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
        '/Home': (context) => const HomeScreen(),
        '/Registrarte': (context) => const RegisterPage(),
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/Ver_Recetas': (context) => const VerRecetaPage(),
        '/Registrar': (context) => const Registrar(),
        '/Notificaciones': (context) => const Notificaciones(),
        '/Busqueda': (context) => const BusquedaScreen(),
        '/Recetas_Otros': (context) => const RecetasOtros(),
      },
    );
  }
}
