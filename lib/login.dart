import 'package:flutter/material.dart';
import 'package:movil2proyecto/database/user_dao.dart';
import 'package:movil2proyecto/model/user_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final userController = TextEditingController();
    final passwordController = TextEditingController();

    void login() async {
      if (_formKey.currentState!.validate()) {
        final userDao = UserDao();
        final user = userController.text.trim();
        final password = passwordController.text.trim();

        final validUser = await userDao.validarLogin(user, password);
        if (validUser != null) {
          Navigator.pushReplacementNamed(context, '/Home');
        } else {
          _showError(context, 'Usuario o contraseña incorrectos.');
        }
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cake, size: 100, color: Color(0xFFE48826)),
                const SizedBox(height: 10),
                const Text('Inicio de Sesión',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE48826))),
                const SizedBox(height: 20),
                _buildInputField(userController, 'Correo electrónico', Icons.person),
                const SizedBox(height: 10),
                _buildInputField(passwordController, 'Contraseña', Icons.lock, obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: _buttonStyle(),
                  onPressed: login,
                  child: const Text('Iniciar Sesión',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text('¿No tienes cuenta? Regístrate',
                      style: TextStyle(color: Color(0xFFBB99B7))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void register() async {
      if (_formKey.currentState!.validate()) {
        final name = nameController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        final userDao = UserDao();
        final existingUsers = await userDao.readAll();
        final exists = existingUsers.any((u) => u.name == email);

        if (exists) {
          _showError(context, 'Ese correo ya está registrado.');
          return;
        }

        final newUser = UserModel(name: email, password: password);
        await userDao.insert(newUser);

        Navigator.pushReplacementNamed(context, '/Home');
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle,
                    size: 100, color: Color(0xFFE48826)),
                const Text('Registro de Usuario',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE48826))),
                const SizedBox(height: 10),
                _buildInputField(nameController, 'Nombre completo', Icons.person),
                const SizedBox(height: 10),
                _buildInputField(emailController, 'Correo electrónico', Icons.email),
                const SizedBox(height: 10),
                _buildInputField(passwordController, 'Contraseña', Icons.lock, obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: _buttonStyle(),
                  onPressed: register,
                  child: const Text('Registrarse',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                      '¿Ya tienes una cuenta? Inicia sesión',
                      style: TextStyle(color: Color(0xFFBB99B7))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInputField(TextEditingController controller, String label, IconData icon,
    {bool obscureText = false}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: const Color(0xFFE48826)),
        ),
      ),
    ),
  );
}

void _showError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
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

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFE48826),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
