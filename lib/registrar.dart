import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _preparacionController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _ingredientesController.dispose();
    _preparacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const  Color.fromRGBO(255, 152, 0, 1),
        title: const Text("Registro de Receta",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                      )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              
              const SizedBox(height: 20),
              Icon(
                Icons.restaurant,
                size: 60,
                color: Colors.orange,
              ),
              const SizedBox(height: 10),
              const Text(
                "Registro de Receta",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 30),
              
              // Formulario
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Título de la receta
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _tituloController,
                        decoration: const InputDecoration(
                          hintText: "Título de la receta",
                          prefixIcon: Icon(Icons.title, color: Colors.orange),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un título';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Descripción
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _descripcionController,
                        decoration: const InputDecoration(
                          hintText: "Descripción",
                          prefixIcon: Icon(Icons.description, color: Colors.orange),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Ingredientes
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _ingredientesController,
                        decoration: const InputDecoration(
                          hintText: "Ingredientes",
                          prefixIcon: Icon(Icons.shopping_basket, color: Colors.orange),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa los ingredientes';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Preparación
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _preparacionController,
                        decoration: const InputDecoration(
                          hintText: "Preparación",
                          prefixIcon: Icon(Icons.food_bank, color: Colors.orange),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        maxLines: 8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa los pasos de preparación';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Botón de registro
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Aquí iría la lógica para guardar la receta en la base de datos
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Receta registrada con éxito')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Registrar Receta",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Enlace para volver
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "¿Ya tienes recetas registradas? Ver listado",
                        style: TextStyle(color: Color.fromRGBO(255, 152, 0, 1)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}