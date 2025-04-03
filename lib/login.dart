import 'package:flutter/material.dart';
import 'package:movil2proyecto/Home_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: const Color(0xFFE48826),
        scaffoldBackgroundColor: const Color(0xFFECC8C9),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFE48826),
          secondary: const Color(0xFFBB99B7),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.brown, fontFamily: 'Arial'),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void login() {
      String user = userController.text;
      String password = passwordController.text;

      if (user.isEmpty || password.isEmpty) {
        _showError(context, 'Por favor, ingrese usuario y contraseña.');
        return;
      }

      if (user == 'usuario' && password == '1234') {
        Navigator.pushReplacementNamed(context, '/Home');
      } else {
        _showError(context, 'Error: Cuenta no registrada.');
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cake, size: 100, color: Color(0xFFE48826)),
              const SizedBox(height: 10),
              const Text(
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE48826),
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(userController, 'Usuario', Icons.person),
              const SizedBox(height: 10),
              _buildInputField(
                passwordController,
                'Contraseña',
                Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: _buttonStyle(),
                onPressed: login,
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Color(0xFFBB99B7)),
                ),
              ),
            ],
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void register() {
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        _showError(context, 'Por favor, complete todos los campos.');
        return;
      }

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const HomePage()));
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Color(0xFFE48826),
              ),
              const Text(
                'Registro de Usuario',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE48826),
                ),
              ),
              const SizedBox(height: 10),
              _buildInputField(nameController, 'Nombre', Icons.person),
              const SizedBox(height: 10),
              _buildInputField(
                emailController,
                'Correo Electrónico',
                Icons.email,
              ),
              const SizedBox(height: 10),
              _buildInputField(
                passwordController,
                'Contraseña',
                Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: _buttonStyle(),
                onPressed: register,
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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
                  style: TextStyle(color: Color(0xFFBB99B7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}

Widget _buildInputField(
  TextEditingController controller,
  String label,
  IconData icon, {
  bool obscureText = false,
}) {
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
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFE48826),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
