import 'package:flutter/material.dart';
import 'package:movil2proyecto/verReceta.dart';
import '../db/database_helper.dart';
import '../models/recetas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registrar extends StatefulWidget {
  final Recipe? recipeToEdit;

  const Registrar({super.key, this.recipeToEdit});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _preparacionController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = false;
  int? _userId;
  bool _isEditing = false; // Nuevo flag para modo edición
  int? _recipeId; // ID de la receta en caso de edición

  @override
  void initState() {
    super.initState();
    _getUserId();

    // Verificar si hay usuario logueado inmediatamente
    _checkLoggedUser();

    // Verificar si estamos en modo edición
    _checkEditMode();
  }

  void _checkEditMode() {
    if (widget.recipeToEdit != null) {
      setState(() {
        _isEditing = true;
        _recipeId = widget.recipeToEdit!.id;
        // Prellenar los campos con la información de la receta
        _tituloController.text = widget.recipeToEdit!.title;
        _descripcionController.text = widget.recipeToEdit!.description;
        _ingredientesController.text = widget.recipeToEdit!.ingredients;
        _preparacionController.text = widget.recipeToEdit!.instructions;
      });
    }
  }

  Future<void> _checkLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes iniciar sesión para agregar recetas'),
        ),
      );

      // Opcionalmente, puedes redirigir al usuario a la pantalla de login
      // Navigator.pushReplacementNamed(context, '/Login');
    } else {
      print("Usuario logueado con ID: $userId");
    }
  }

  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('userId');
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _ingredientesController.dispose();
    _preparacionController.dispose();
    super.dispose();
  }

  Future<void> _saveRecipe() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No hay usuario logueado')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Recipe recipe = Recipe(
        id: _isEditing ? _recipeId : null, // Si estamos editando, incluir el ID
        userId: _userId!,
        title: _tituloController.text,
        description: _descripcionController.text,
        ingredients: _ingredientesController.text,
        instructions: _preparacionController.text,
        createdAt:
            _isEditing
                ? widget
                    .recipeToEdit!
                    .createdAt // Mantener la fecha original si estamos editando
                : _dbHelper
                    .getCurrentDateTime(), // Nueva fecha para recetas nuevas
      );

      int result;

      if (_isEditing) {
        // Actualizar receta existente
        result = await _dbHelper.updateRecipe(recipe);
        if (result > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Receta actualizada con éxito')),
          );
        }
      } else {
        // Insertar nueva receta
        result = await _dbHelper.insertRecipe(recipe);
        if (result > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Receta registrada con éxito')),
          );
        }
      }

      if (result > 0) {
        // Limpiamos el formulario
        _tituloController.clear();
        _descripcionController.clear();
        _ingredientesController.clear();
        _preparacionController.clear();

        // Navegamos a la pantalla de ver recetas
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerRecetas()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la receta')),
        );
      }
    } catch (e) {
      print("Error al guardar receta: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: Text(
          _isEditing ? "Editar Receta" : "Registro de Receta",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
        centerTitle: true,
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Icon(Icons.restaurant, size: 60, color: Colors.orange),
                      const SizedBox(height: 10),
                      Text(
                        _isEditing ? "Editar Receta" : "Registro de Receta",
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
                                  prefixIcon: Icon(
                                    Icons.title,
                                    color: Colors.orange,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
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
                                  prefixIcon: Icon(
                                    Icons.description,
                                    color: Colors.orange,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
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
                                  prefixIcon: Icon(
                                    Icons.shopping_basket,
                                    color: Colors.orange,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
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
                                  prefixIcon: Icon(
                                    Icons.food_bank,
                                    color: Colors.orange,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
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

                            // Botón de registro/actualización
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _saveRecipe();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  _isEditing
                                      ? "Actualizar Receta"
                                      : "Registrar Receta",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Enlace para ver recetas (se muestra solo en modo de creación)
                            if (!_isEditing)
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VerRecetas(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "¿Ya tienes recetas registradas? Ver listado",
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 152, 0, 1),
                                  ),
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
