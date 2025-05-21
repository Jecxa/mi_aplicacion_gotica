import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokéApp Gótica',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1B26),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Unifraktur', fontSize: 20),
        ),
      ),
      home: const PokeScreen(),
    );
  }
}

class Pokemon {
  final String name;
  final String imageUrl;

  Pokemon({required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}

Future<Pokemon> fetchPokemon(String name) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));

  if (response.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al cargar el Pokémon');
  }
}

class PokeScreen extends StatelessWidget {
  const PokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Pokemon>(
        future: fetchPokemon('pikachu'), // Puedes cambiarlo por cualquier Pokémon
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(pokemon.imageUrl),
                  const SizedBox(height: 20),
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Unifraktur',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No se encontró el Pokémon'));
          }
        },
      ),
    );
  }
}
