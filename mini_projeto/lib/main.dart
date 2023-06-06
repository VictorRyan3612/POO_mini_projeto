import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'free_games.dart';
import 'dashboard_menu.dart';
import 'tela_config.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentBrightness = useState(Brightness.dark);
    
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)
    );
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175)
    );

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      
      theme: currentBrightness.value == Brightness.dark ? darkTheme : lightTheme,

      
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardMenu(),
        '/FreeGames':(context) => const FreeGames(),
        '/freeGames/gameDetails': (context) => const FreeGameDetailsScreen(),
        '/Configs':(context) => TelaConfigs(currentBrightness: currentBrightness),
      },
    );
  }
}
