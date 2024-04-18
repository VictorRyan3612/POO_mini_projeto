import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TelaConfigs extends HookWidget{
  final ValueNotifier<Brightness> currentBrightness;

  const TelaConfigs({required this.currentBrightness, super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações"),),

      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  ListTile(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}