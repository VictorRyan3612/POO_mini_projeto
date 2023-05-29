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
      home: HomePageApp(_currentBrightness)
      );
    
  }
}


class HomePageApp extends HookWidget{
  final ValueNotifier<Brightness> _currentBrightness;

  const HomePageApp(this._currentBrightness, {super.key});


  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: MyAppBar(_currentBrightness)
    );
  }
}



class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final ValueNotifier<Brightness> _currentBrightness;

  const MyAppBar(this._currentBrightness, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context){
    return AppBar(
      title: Text("Mini projeto"),
    );
  }
}