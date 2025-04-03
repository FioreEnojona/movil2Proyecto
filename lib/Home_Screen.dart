import 'package:flutter/material.dart';
import 'package:movil2proyecto/Busqueda.dart';
import 'package:movil2proyecto/verReceta.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  final List<Widget> _pages = [
    const HomePage(),
    const BusquedaScreen(),
    const VerRecetaPage(),
  ];

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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = SearchController();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchBar(
                controller: searchController,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                leading: const Icon(Icons.search),
                hintText: 'Buscar...',
                hintStyle: WidgetStateProperty.all(
                  const TextStyle(color: Colors.white70),
                ),
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(233, 241, 139, 30),
                ),
                textStyle: WidgetStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onSubmitted: (value) {},
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Ingredientes Más Buscados',
              style: TextStyle(
                color: const Color.fromARGB(255, 252, 115, 3),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(cardNames.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                RecipeScreen(ingredient: cardNames[index]),
                      ),
                    );
                  },
                  child: _SampleCard(cardName: cardNames[index]),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text('Búsquedas Recientes', style: _titleStyle()),
            const SizedBox(height: 10),
            Column(
              children:
                  recentSearches
                      .map((search) => RecentSearchTile(search))
                      .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Recetas Publicadas Últimamente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 252, 115, 3),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    latestRecipes.map((recipe) => RecipeCard(recipe)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeScreen extends StatelessWidget {
  final String ingredient;

  const RecipeScreen({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recetas con $ingredient')),
      body: Center(
        child: Text('Aquí irían las recetas relacionadas con $ingredient'),
      ),
    );
  }
}

TextStyle _titleStyle() {
  return const TextStyle(
    color: Color.fromARGB(255, 252, 115, 3),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

final List<Map<String, String>> recentSearches = [
  {
    'title': 'Arándanos',
    'date': 'Hace 6 días',
    'image':
        'https://cdn.pixabay.com/photo/2016/03/05/19/02/blueberries-1238249_1280.jpg',
  },
  {
    'title': 'Espaguetis',
    'date': '19 mar 2025',
    'newRecipes': '6 recetas nuevas',
    'image':
        'https://cdn.pixabay.com/photo/2017/11/08/22/18/spaghetti-2931846_1280.jpg',
  },
  {
    'title': 'Arroz',
    'date': '19 mar 2025',
    'newRecipes': '+10 recetas nuevas',
    'image':
        'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg',
  },
];

final List<Map<String, String>> latestRecipes = [
  {
    'title': 'Alambre de pollo con nopal',
    'author': 'Brenda Martinez',
    'image':
        'https://cdn.pixabay.com/photo/2022/06/07/21/00/chicken-7249273_1280.jpg',
  },
  {
    'title': 'Galletas con chispas de chocolate',
    'author': 'Ángeles Ávila',
    'image':
        'https://cdn.pixabay.com/photo/2020/04/22/17/24/strawberry-5079237_1280.jpg',
  },
  {
    'title': 'Risotto con pollo              sabroso',
    'author': 'Angerith Calvo',
    'image':
        'https://cdn.pixabay.com/photo/2018/08/29/19/03/steak-3640560_1280.jpg',
  },
  {
    'title': 'Alambre de pollo con nopal',
    'author': 'Brenda Martinez',
    'image':
        'https://cdn.pixabay.com/photo/2022/06/07/21/00/chicken-7249273_1280.jpg',
  },
  {
    'title': 'Galletas con chispas de chocolate',
    'author': 'Ángeles Ávila',
    'image':
        'https://cdn.pixabay.com/photo/2020/04/22/17/24/strawberry-5079237_1280.jpg',
  },
  {
    'title': 'Risotto con pollo             delicioso  ',
    'author': 'Angerith Calvo',
    'image':
        'https://cdn.pixabay.com/photo/2018/08/29/19/03/steak-3640560_1280.jpg',
  },
];

final List<String> cardNames = [
  'Pollo',
  'Carne',
  'Pescado',
  'Arroz',
  'Pasta',
  'Ensalada',
  'Sopa',
  'Fresa',
];

final Map<String, String> cardBackgroundImages = {
  'Pollo':
      'https://cdn.pixabay.com/photo/2022/06/07/21/00/chicken-7249273_1280.jpg',
  'Carne':
      'https://cdn.pixabay.com/photo/2018/08/29/19/03/steak-3640560_1280.jpg',
  'Pescado':
      'https://cdn.pixabay.com/photo/2016/03/05/19/02/salmon-1238248_640.jpg',
  'Arroz':
      'https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_1280.jpg',
  'Pasta':
      'https://cdn.pixabay.com/photo/2017/11/08/22/18/spaghetti-2931846_640.jpg',
  'Ensalada':
      'https://cdn.pixabay.com/photo/2017/10/09/19/29/salad-2834549_640.jpg',
  'Sopa':
      'https://cdn.pixabay.com/photo/2017/03/10/13/57/cooking-2132874_640.jpg',
  'Fresa':
      'https://cdn.pixabay.com/photo/2020/04/22/17/24/strawberry-5079237_1280.jpg',
};

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(cardBackgroundImages[cardName]!),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            cardName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecentSearchTile extends StatelessWidget {
  final Map<String, String> search;
  const RecentSearchTile(this.search, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            search['image']!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          search['title']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              search['date']!,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
            if (search.containsKey('newRecipes'))
              Text(
                search['newRecipes']!,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Map<String, String> recipe;
  const RecipeCard(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              recipe['image']!,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recipe['title']!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          Text(
            recipe['author']!,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
