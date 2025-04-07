import 'package:flutter/material.dart';
import 'verReceta.dart';
import 'Busqueda.dart';
import 'recetasOtros.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _currentIndex = 0;

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(onTap: _navigateToPage),
      const BusquedaScreen(),
      const VerRecetaPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 150, 0),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/logo_chocobite.jpg',
                height: 36,
                width: 36,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'ChocoBite',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text("Cerrar sesión"),
                      content: const Text(
                        "¿Estás seguro de que querés cerrar sesión?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                          },
                          child: const Text("Cerrar sesión"),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _navigateToPage,
        indicatorColor: const Color.fromARGB(255, 255, 168, 7),
        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: Colors.white),
            icon: Icon(Icons.search_outlined),
            label: 'Buscar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.receipt_long, color: Colors.white),
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Recetas',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(int) onTap;
  const HomePage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          _buildMenuButton(
            context,
            icon: Icons.home,
            label: 'Inicio',
            route: '/Inicio',
          ),
          const SizedBox(height: 20),
          _buildMenuButton(
            context,
            icon: Icons.add_circle_outline,
            label: 'Añadir Receta',
            route: '/Registrar',
          ),
          const SizedBox(height: 20),
          _buildMenuButton(
            context,
            icon: Icons.edit,
            label: 'Editar Perfil',
            route: '/editar_perfil',
          ),
          const SizedBox(height: 20),
          _buildMenuButton(
            context,
            icon: Icons.notifications_none,
            label: 'Ver Notificaciones',
            route: '/Notificaciones',
          ),
          const SizedBox(height: 20),
          _buildMenuButton(
            context,
            icon: Icons.people_alt_outlined,
            label: 'Ver Receta de Otros',
            route: '/Recetas_Otros',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
