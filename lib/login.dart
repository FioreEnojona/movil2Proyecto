import 'package:flutter/material.dart';
import 'package:movil2proyecto/db/database_helper.dart';
import 'package:movil2proyecto/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final dbHelper = DatabaseHelper();
  bool _obscureText = true;

  Future<void> login() async {
    String email = userController.text;
    String password = passwordController.text;

    print("Intentando iniciar sesión con: $email");

    if (email.isEmpty || password.isEmpty) {
      _showError(context, 'Por favor, ingrese usuario y contraseña.');
      return;
    }

    User? user = await dbHelper.verifyLogin(email, password);
    print(
      "Resultado de verificación: ${user != null ? 'Usuario encontrado' : 'Usuario no encontrado'}",
    );

    if (user != null) {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
        'userId',
        user.id!,
      ); 

      print("userId guardado en SharedPreferences: ${user.id}");

      Navigator.pushReplacementNamed(context, '/Home');
    } else {
      _showError(
        context,
        'Error: Cuenta no registrada o credenciales incorrectas.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _buildInputField(userController, 'Correo', Icons.person),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: const Color(0xFFE48826),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFFE48826),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: _buttonStyle(),
                onPressed: () => login(),
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final dbHelper = DatabaseHelper();
  bool _obscureText = true;


  String? emailError;
  String? passwordError;

  bool isValidEmail(String email) {

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isStrongPassword(String password) {

    if (password.length < 8) {
      passwordError = "La contraseña debe tener al menos 8 caracteres";
      return false;
    }


    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      passwordError =
          "La contraseña debe contener al menos una letra mayúscula";
      return false;
    }


    if (!RegExp(r'[a-z]').hasMatch(password)) {
      passwordError =
          "La contraseña debe contener al menos una letra minúscula";
      return false;
    }


    if (!RegExp(r'[0-9]').hasMatch(password)) {
      passwordError = "La contraseña debe contener al menos un número";
      return false;
    }


    if (!RegExp(r'[!@#\$%\^&\*\(\),.?":{}|<>]').hasMatch(password)) {
      passwordError =
          "La contraseña debe contener al menos un carácter especial";
      return false;
    }

    return true;
  }

  Future<void> register() async {
    try {
      setState(() {
        emailError = null;
        passwordError = null;
      });

      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      print("Intentando registrar: Nombre=$name, Email=$email");

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        print("Error: Campos vacíos");
        _showError(context, 'Por favor, complete todos los campos.');
        return;
      }


      if (!isValidEmail(email)) {
        setState(() {
          emailError = "Por favor, ingrese un correo electrónico válido";
        });
        return;
      }


      if (!isStrongPassword(password)) {
        setState(() {
          
        });
        return;
      }


      print("Verificando si el email ya existe...");
      bool exists = await dbHelper.emailExists(email);
      print("¿Email existe?: $exists");

      if (exists) {
        print("Error: Email ya registrado");
        _showError(context, 'Este correo electrónico ya está registrado.');
        return;
      }


      User newUser = User(name: name, email: email, password: password);

      print("Insertando usuario en la base de datos...");
      int result = await dbHelper.insertUser(newUser);
      print("Resultado de inserción: $result");

      if (result > 0) {
        print("Registro exitoso - Mostrando diálogo");

        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Éxito'),
                content: Text('Registro exitoso. Ahora puedes iniciar sesión.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );


        print("Diálogo cerrado, volviendo a login");
        Navigator.pop(context); 
      } else {
        print("Error en el registro");
        _showError(context, 'Hubo un error al registrar el usuario.');
      }
    } catch (e) {
      print("Excepción durante el registro: $e");
      _showError(context, 'Error inesperado: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email,
                          color: const Color(0xFFE48826),
                        ),
                        errorText: emailError,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: const Color(0xFFE48826),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFFE48826),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        errorText: passwordError,
                      ),
                    ),
                  ),
                ),
                if (passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Requisitos: al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: _buttonStyle(),
                  onPressed: () => register(),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
      ),
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

void _showInfo(BuildContext context, String message) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Información'),
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
