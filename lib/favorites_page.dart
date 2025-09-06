import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos")),
      body: const Center(
        child: Text(
          "Aquí estarán tus productos favoritos 💛",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
