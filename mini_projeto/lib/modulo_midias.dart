import 'package:flutter/material.dart';


class ModuloMidia extends StatelessWidget {
  const ModuloMidia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo Midias'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Voltar!'),
        ),
      ),
    );
  }
}