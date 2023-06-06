import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'var_json.dart';

class FreeGames extends HookWidget {
  const FreeGames({super.key});



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


    // void navigateToGameDetails(BuildContext context, dynamic game) {
    //   Navigator.pushNamed(context, '/freeGames/gameDetails', arguments: game);
    // }

    if (fim.value == "Sucesso"){
      
      return Scaffold(
        appBar: AppBar(
          title: Text("Lista de jogos Grátis"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: games.value.length,
            itemBuilder: (BuildContext context, int index) {
              final game = games.value[index];

              return InkWell(
                onLongPress: () => print(game),
                // onTap: () => navigateToGameDetails(context, game),
                child: ListTile(
                  title: Text(game['title']),
                  subtitle: Text(game['genre']),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(game['thumbnail'])
                  ),
                ),
              );
            }
          ),
        )
      );
    }

    else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    

  }
}