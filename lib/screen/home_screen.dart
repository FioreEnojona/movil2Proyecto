import 'package:flutter/material.dart';
import 'package:proyectomovil2flutter/screen/notificaciones.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(233, 241, 139, 30),
        title: const Text(" Pagina Principal"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => notificaciones()),
                  ),
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
                  color: Color.fromARGB(199, 106, 36, 176),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 49, 173, 11),
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 179, 6, 6),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(child: _SampleCard(cardName: 'Elevated Card')),
                    Card.filled(child: _SampleCard(cardName: 'Filled Card')),
                    Card.outlined(
                      child: _SampleCard(cardName: 'Outlined Card'),
                    ),
                    Card(child: _SampleCard(cardName: 'Elevated Card')),
                    Card.filled(child: _SampleCard(cardName: 'Filled Card')),
                    Card.outlined(
                      child: _SampleCard(cardName: 'Outlined Card'),
                    ),
                    Card(child: _SampleCard(cardName: 'Elevated Card')),
                    Card.filled(child: _SampleCard(cardName: 'Filled Card')),
                    Card.outlined(
                      child: _SampleCard(cardName: 'Outlined Card'),
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

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}
