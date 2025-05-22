import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_screen.dart';
import 'movie_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  void _irAAdmin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AdminScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E1B26),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Menú Gótico',
                style: TextStyle(
                  fontFamily: 'Unifraktur',
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.movie, color: Colors.white),
              title: const Text('Catálogo', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Solo cierra el Drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Administrar', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _irAAdmin(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _logout(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1E1B26),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Catálogo de Películas',
          style: TextStyle(fontFamily: 'Unifraktur'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Películas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar el catálogo'));
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(
              child: Text('No hay películas aún', style: TextStyle(color: Colors.white)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final pelicula = docs[index];

              return Card(
                color: Colors.deepPurple[800],
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Image.network(pelicula['imagenUrl'], width: 60, fit: BoxFit.cover),
                  title: Text(
                    pelicula['titulo'],
                    style: const TextStyle(
                      fontFamily: 'Unifraktur',
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    pelicula['genero'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(
                          titulo: pelicula['titulo'],
                          anio: pelicula['anio'],
                          director: pelicula['director'],
                          genero: pelicula['genero'],
                          sinopsis: pelicula['sinopsis'],
                          imagenUrl: pelicula['imagenUrl'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
