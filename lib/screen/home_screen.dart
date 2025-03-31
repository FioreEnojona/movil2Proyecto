import 'package:flutter/material.dart';
import 'package:proyectomovil2flutter/screen/notificaciones.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

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
                MaterialPageRoute(builder: (context) => notificaciones()),
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
            ],
          ),
        ),
      ),
    );
  }
}

// Mapa de imágenes de fondo para cada categoría
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
