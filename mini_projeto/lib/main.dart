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
      home: HomePageApp(_currentBrightness),
      
      routes: {
        '/gameDetails': (context) => GameDetailsScreen(),
      },
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


    void navigateToGameDetails(BuildContext context, dynamic game) {
      Navigator.pushNamed(context, '/gameDetails', arguments: game);
    }

    if (fim.value == "Sucesso"){
      return ListView.builder(
        itemCount: games.value.length,
        itemBuilder: (BuildContext context, int index) {
          final game = games.value[index];
          return InkWell(
            onTap: () => navigateToGameDetails(context, game),
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


class GameDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic game = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(game["title"]),
      ),
      body: Center(
        
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Image.network(
              game['thumbnail'],
              height: 200,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: gamesinfo.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: 
                    Text('${item['nameProp']} ${game[item['prop']]}', 
                      style: TextStyle(fontSize: item['fontsize'])
                    )
                );
              }).toList()

              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Game Details:',
              //       style: TextStyle(fontSize: 24),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Image.network(
              //       game['thumbnail'],
              //       height: 200,
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Title: ${game['title']}',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Genre: ${game['genre']}',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //   ),
              // ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> gamesinfo = [
  
  {
    'nameProp': 'Title:',
    'prop': 'title',
    'fontsize': 18.0,
    'height': 16.0
  }
];