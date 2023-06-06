import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MainApp());
}

class MainApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _currentBrightness = useState(Brightness.dark);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Jogos Grátis',
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
      appBar: MyAppBar(_currentBrightness),

      body: GamesList(),
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
      title: Text(
        "Lista de jogos grátis", 
        style: TextStyle(fontSize: 25)
      ),

      actions: [
        PopupMenuButton<Brightness>(
          icon: const Icon(Icons.more_vert),
          onSelected: (Brightness brightness) {
            _currentBrightness.value = brightness;
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<Brightness>(
              value: Brightness.light,
              child: Text('Tema Claro'),
            ),
            const PopupMenuItem<Brightness>(
              value: Brightness.dark,
              child: Text('Tema Escuro'),
            ),
          ],
        ),
      ]
    );
  }
}


class GamesList extends HookWidget {
  const GamesList({super.key});

  @override
  Widget build(BuildContext context) {
    final fim = useState("Não testado");
    final games = useState<List<dynamic>>([]);

    Future<void> fetchData() async {
      try {
        final response = await http.get(Uri.parse('https://www.freetogame.com/api/games'));

        final jsonResponse = jsonDecode(response.body);
        games.value = jsonResponse;
        fim.value = "Sucesso";
      } 
      catch (error) {
        var a = error.runtimeType.toString();
        fim.value = "Erro: $a";
      }

    }
    

    useEffect(() {
      fetchData();
    }, []);

    if (fim.value == "Sucesso"){
      return ListView.builder(
        itemCount: games.value.length,
        itemBuilder: (BuildContext context, int index) {
          final game = games.value[index];
          return InkWell(
            onTap: () {
              
            },
            child: ListTile(
              title: Text(game['title']),
              subtitle: Text(game['genre']),
              leading: Image.network(game['thumbnail']),
            ),
          );
        }
      );
    }

    else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    

  }
}

