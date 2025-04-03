import 'package:flutter/material.dart';

// PANTALLAS PRINCIPALES
import 'package:movil2proyecto/login.dart';
import 'package:movil2proyecto/Home_Screen.dart';
import 'package:movil2proyecto/editar_perfil.dart';
import 'package:movil2proyecto/verReceta.dart';
import 'package:movil2proyecto/registrar.dart';
import 'package:movil2proyecto/notificaciones.dart';
import 'package:movil2proyecto/Busqueda.dart';
import 'package:movil2proyecto/recetasOtros.dart';

// BASE DE DATOS
import 'package:movil2proyecto/database/user_dao.dart';
import 'package:movil2proyecto/model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chocobite',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF9800),
        scaffoldBackgroundColor: const Color(0xFFFFF5F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF9800),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/Home': (context) => const HomeScreen(),
        '/Registrarte': (context) => const RegisterPage(),
        '/Registrar': (context) => const Registrar(),
        '/Ver_Recetas': (context) => const VerRecetaPage(),
        '/Notificaciones': (context) => const Notificaciones(),
        '/editar_perfil': (context) => const EditarPerfilScreen(),
        '/Busqueda': (context) => const BusquedaScreen(),
        '/RecetasOtros': (context) => const RecetasOtros(),
      },
    );
  }
}
