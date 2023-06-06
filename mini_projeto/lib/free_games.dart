import 'package:flutter/material.dart';


class FreeGames extends StatelessWidget {
  const FreeGames({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogos Grátis'),
      ),
      body: Center(
        child: const Text('Voltar!'),
      ),
    );
  }
}