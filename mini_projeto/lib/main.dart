import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


void main() {
  runApp(MainApp());
}

class MainApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _currentBrightness = useState(Brightness.dark);

    return MaterialApp(
      title: 'Mudança de Tema',
      theme: ThemeData(
        brightness: _currentBrightness.value,
        primarySwatch: Colors.blue,
      ),
      home: Text("Processo de mudança de tema")
      );
    
  }
}

