import 'package:flutter/material.dart';
import 'package:movil2proyecto/models/user.dart';
import 'package:movil2proyecto/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  String? emailError;
  String? passwordError;
  String? currentUserName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      User? user = await DatabaseHelper().getUser(userId);
      if (user != null) {
        setState(() {
          currentUserName = user.name;
          nameController.text = user.name;
          emailController.text = user.email;
          passwordController.text = user.password;
        });
      }
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isStrongPassword(String password) {
    if (password.length < 8) {
      passwordError = "Debe tener al menos 8 caracteres";
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      passwordError = "Debe tener al menos una letra mayúscula";
      return false;
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      passwordError = "Debe tener al menos una letra minúscula";
      return false;
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      passwordError = "Debe tener al menos un número";
      return false;
    }
    if (!RegExp(r'[!@#\$%\^&\*\(\),.?":{}|<>]').hasMatch(password)) {
      passwordError = "Debe tener al menos un carácter especial";
      return false;
    }
    return true;
  }

  void guardarCambios() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError(context, "Todos los campos son obligatorios.");
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        emailError = "Correo electrónico inválido";
      });
      return;
    }

    if (!isStrongPassword(password)) {
      setState(() {}); // Muestra el error de contraseña
      return;
    }

    // Obtener el ID del usuario logueado
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId == null) {
      _showError(context, "Error al obtener el usuario actual.");
      return;
    }

    // Crear objeto User con nuevos datos
    User updatedUser = User(
      id: userId,
      name: name,
      email: email,
      password: password,
    );

    // Actualizar en la base de datos
    int result = await DatabaseHelper().updateUser(updatedUser);

    if (result > 0) {
      _showSuccessAndLogout(
        context,
        "Los datos fueron actualizados correctamente.\nSe cerrará la sesión.",
      );
    } else {
      _showError(context, "Ocurrió un error al actualizar el perfil.");
    }
  }

  void _showSuccessAndLogout(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // No se puede cerrar tocando afuera
      builder:
          (context) =>
              AlertDialog(title: const Text('Éxito'), content: Text(message)),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Cierra el diálogo
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      ); // Navega a inicio y elimina rutas anteriores
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF9),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 150, 0),
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (currentUserName != null)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange.shade300,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    currentUserName!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInputField(
                controller: nameController,
                label: 'Nombre',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: emailController,
                label: 'Correo Electrónico',
                icon: Icons.email,
                errorText: emailError,
              ),
              const SizedBox(height: 20),
              _buildPasswordField(),
              if (passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    passwordError!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: guardarCambios,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Guardar Cambios',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? errorText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.orange),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          errorText: errorText,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          prefixIcon: const Icon(Icons.lock, color: Colors.orange),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.orange,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Éxito'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
