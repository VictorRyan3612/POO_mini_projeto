import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'var_json.dart';

class SaleGames extends HookWidget {
const SaleGames({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){




    final fim = useState("Não testado");
    final games = useState<List<dynamic>>([]);

    Future<void> fetchData() async {
      try {
        final response = await http.get(Uri.parse('https://www.cheapshark.com/api/1.0/deals?storeID=1'));

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
      return null;
    }, []);


    void navigateToGameDetails(BuildContext context, dynamic game) {
      Navigator.pushNamed(context, '/SalesGames/gameDetails', arguments: game);
    }
    return Scaffold(
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
                  subtitle: Text(game['normalPrice']),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(game['thumb'])
                  ),
                ),
              );
            }
          ),
        )
    );
  }
}



class SaleGamesDetailsScreen extends StatelessWidget {
  const SaleGamesDetailsScreen({super.key});

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
                    game['thumb'],
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
