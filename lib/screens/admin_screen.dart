import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _anioController = TextEditingController();
  final _generoController = TextEditingController();
  final _directorController = TextEditingController();
  final _sinopsisController = TextEditingController();
  final _imagenUrlController = TextEditingController();

  bool _loading = false;
  String? _mensaje;

  Future<void> _guardarPelicula() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _mensaje = null;
    });

    try {
      await FirebaseFirestore.instance.collection('Películas').add({
        'titulo': _tituloController.text.trim(),
        'anio': _anioController.text.trim(),
        'genero': _generoController.text.trim(),
        'director': _directorController.text.trim(),
        'sinopsis': _sinopsisController.text.trim(),
        'imagenUrl': _imagenUrlController.text.trim(),
      });

      setState(() {
        _mensaje = 'Película guardada exitosamente';
      });

      _formKey.currentState!.reset();
      _tituloController.clear();
      _anioController.clear();
      _generoController.clear();
      _directorController.clear();
      _sinopsisController.clear();
      _imagenUrlController.clear();
    } catch (e) {
      setState(() {
        _mensaje = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _anioController.dispose();
    _generoController.dispose();
    _directorController.dispose();
    _sinopsisController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1B26),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Administrar Catálogo',
          style: TextStyle(fontFamily: 'Unifraktur'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _campo('Título', _tituloController),
              _campo('Año', _anioController),
              _campo('Género', _generoController),
              _campo('Director', _directorController),
              _campo('Sinopsis', _sinopsisController, maxLines: 3),
              _campo('URL de imagen', _imagenUrlController),
              const SizedBox(height: 20),
              if (_mensaje != null)
                Text(
                  _mensaje!,
                  style: TextStyle(
                    color: _mensaje!.startsWith('Error') ? Colors.red : Colors.green,
                  ),
                ),
              const SizedBox(height: 20),
              _loading
                  ? const Center(child: CircularProgressIndicator(color: Colors.deepPurple))
                  : ElevatedButton(
                      onPressed: _guardarPelicula,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Guardar Película'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }
}
