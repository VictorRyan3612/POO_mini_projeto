import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'var_json.dart';
import 'dataservice.dart';

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
      dataService.fetchFreeGamesData();
      return null;
    }, []);


    void navigateToGameDetails(BuildContext context, dynamic game) {
      Navigator.pushNamed(context, '/freeGames/gameDetails', arguments: game);
    }
    return
    ValueListenableBuilder(
      valueListenable: dataService.gameStateNotifier,
      builder: (_, value, __) {
        switch (value['status']) {

          case StatusApp.loading:
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Carregando")
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );

          case StatusApp.idle:
            return const Text("...");

          case StatusApp.ready:
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Lista de jogos Grátis"),
                ),
                body: Center(
                  child: ListView.builder(
                    itemCount: games.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final game = games.value[index];
            
                      return InkWell(
                        onLongPress: () => print(game),
                        onTap: () => navigateToGameDetails(context, game),
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
              ),
            );
          case StatusApp.error:
            return 
            const Center(
              child: Text("error")
            );
        }
        return const Text("Erro desconhecido" ''); 
      }
    );
  }
}


class FreeGameDetailsScreen extends StatelessWidget {
  const FreeGameDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic game = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(game["title"]),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    game['thumbnail'],
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: gamesinfo.map((item) {
              
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: 
                        Text('${item['nameProp']} \t${game[item['prop']]}',
                          style: TextStyle(fontSize: item['fontsize'])
                        )
                    );
                  }).toList()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
