import 'package:flutter/material.dart';
import 'package:movil2proyecto/screen/verReceta.dart';
import 'package:proyectomovil2flutter/registrar.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerRecetaPage(),
    );
  }
}

   return const MaterialApp(
    
     home:Registrar(),

   );

}
}