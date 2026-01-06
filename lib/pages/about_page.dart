import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Cette application démontre l'utilisation des thèmes et styles en Flutter.",
        ),
      ),
    );
  }
}
