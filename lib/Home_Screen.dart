import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      const VerRecetasScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 150, 0),
        title: const Center(
          child: Text(
            "Chocobites",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/Registrar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Añadir Receta',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/editar_perfil'),
            style: ElevatedButton.styleFrom(
              backgroundColor:  Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Editar Perfil',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class BusquedaScreen extends StatelessWidget {
  const BusquedaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Recetas')),
      body: const Center(child: Text('Buscar Recetas')),
    );
  }
}

class VerRecetasScreen extends StatelessWidget {
  const VerRecetasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recetas de Otros')),
      body: const Center(child: Text('Recetas de Otros')),
    );
  }
}
