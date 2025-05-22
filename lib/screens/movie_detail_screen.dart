import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String titulo;
  final String anio;
  final String director;
  final String genero;
  final String sinopsis;
  final String imagenUrl;

  const MovieDetailScreen({
    super.key,
    required this.titulo,
    required this.anio,
    required this.director,
    required this.genero,
    required this.sinopsis,
    required this.imagenUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1B26),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          titulo,
          style: const TextStyle(fontFamily: 'Unifraktur'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(imagenUrl, height: 300, fit: BoxFit.cover),
            const SizedBox(height: 24),
            Text(
              'Año: $anio',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Director: $director',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Género: $genero',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              sinopsis,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
