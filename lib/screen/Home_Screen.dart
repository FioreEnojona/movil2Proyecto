import 'package:flutter/material.dart';
import 'package:movil2proyecto/notificaciones.dart';

class HomeScreen extends StatelessWidget {
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

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(233, 241, 139, 30),
        title: const Text("Pagina Principal"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notificaciones()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(233, 241, 139, 30),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 249, 249, 249),
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 249, 249, 249),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Ingredientes Más Buscados',
                style: TextStyle(
                  color: const Color.fromARGB(255, 252, 115, 3),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
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
              SizedBox(height: 20),
              Text('Búsquedas Recientes', style: _titleStyle()),
              SizedBox(height: 10),
              Column(
                children:
                    recentSearches
                        .map((search) => RecentSearchTile(search))
                        .toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Recetas Publicadas Últimamente',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 252, 115, 3),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      latestRecipes
                          .map((recipe) => RecipeCard(recipe))
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle _titleStyle() {
  return TextStyle(
    color: Color.fromARGB(255, 252, 115, 3),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

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
            style: TextStyle(
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

class RecentSearchTile extends StatelessWidget {
  final Map<String, String> search;
  const RecentSearchTile(this.search, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              search['date']!,
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
            if (search.containsKey('newRecipes'))
              Text(
                search['newRecipes']!,
                style: TextStyle(
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
      margin: EdgeInsets.only(right: 10),
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
          SizedBox(height: 8),
          Text(
            recipe['title']!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          Text(recipe['author']!, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
