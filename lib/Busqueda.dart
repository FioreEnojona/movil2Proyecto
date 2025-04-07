import 'dart:async'; // Añade esta importación

import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/recetas.dart';

class BusquedaScreen extends StatefulWidget {
  const BusquedaScreen({Key? key}) : super(key: key);

  @override
  _BusquedaScreenState createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _searchResults = [];
  bool _isSearching = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final results = await _dbHelper.searchRecipes(query);

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  void _onSearchTextChanged(String text) {
    // Cancelar el timer anterior si existe
    _debounceTimer?.cancel();

    // Establecer un nuevo timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 150, 0),
        title: const Text(
          'Buscar Recetas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Buscar recetas...',
                  labelStyle: const TextStyle(color: Colors.orange),
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.orange),
                            onPressed: () {
                              _searchController.clear();
                              _performSearch('');
                            },
                          )
                          : null,
                ),
                onChanged: _onSearchTextChanged,
              ),
            ),
            const SizedBox(height: 20),
            _isSearching
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE48826)),
                )
                : _searchResults.isEmpty
                ? Expanded(
                  child: Center(
                    child: Text(
                      _searchController.text.isEmpty
                          ? 'Ingresa un término de búsqueda'
                          : 'No se encontraron recetas',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final recipe = _searchResults[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: const Icon(
                            Icons.restaurant_menu,
                            color: Color(0xFFE48826),
                          ),
                          title: Text(
                            recipe.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE48826),
                            ),
                          ),
                          subtitle: Text(
                            recipe.description.isNotEmpty
                                ? recipe.description
                                : 'Sin descripción',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Color(0xFFE48826),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
