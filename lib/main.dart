import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sombras Digitales',
      home: const GothicHome(),
    );
  }
}

class GothicHome extends StatefulWidget {
  const GothicHome({super.key});

  @override
  State<GothicHome> createState() => _GothicHomeState();
}

class _GothicHomeState extends State<GothicHome> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _player.setSource(AssetSource('audio/musica_gotica.mp3'));
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo_gotico.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Texto centrado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Bienvenido al Templo del Código',
                  style: TextStyle(
                    fontFamily: 'Unifraktur',
                    fontSize: 32,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Aplicación: Sombras Digitales',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
