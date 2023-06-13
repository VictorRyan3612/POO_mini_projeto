import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'var_json.dart';
import 'form.dart';

import 'dataservice.dart';

class SaleGames extends HookWidget {
const SaleGames({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
  
    useEffect(() {
      dataService.fetchSalesGamesData();
      return null;
    }, []);


    void navigateToGameDetails(BuildContext context, dynamic game) {
      Navigator.pushNamed(context, '/SalesGames/gameDetails', arguments: game);
    }
    return
    ValueListenableBuilder(
      valueListenable: dataService.gameStateNotifier,
      builder: (_, value, __) {
        switch (value['status']) {

          case StatusApp.idle:
            return const Text("...");

          case StatusApp.loading:
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Carregando")
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              
          case StatusApp.ready:
            List games = value['games'];
            return Scaffold(
              appBar: AppBar(
                  title: const Text("Jogos em Promoção"),
                ),
                body: Column (
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape:MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                  )
                                )
                              ),
                              onPressed:() => dataService.fetchSalesGamesData(cancelar: true),
                              child: const Text("Cancelar filtros")
                            ),
                          ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: 
                              Center(
                                child: MySteamFormFilterDrop(),
                            ),
                          )
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: 
                              Center(
                                child: MySteamFormFilterValor(),
                            ),
                          )
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: MySteamFormSort(),
                            )
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                  child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (BuildContext context, int index) {
                      final game = games[index];

                      return InkWell(
                        onLongPress: () => print(game),
                        onTap: () => navigateToGameDetails(context, game),
                        child: ListTile(
                          title: Text(game['title']),
                          subtitle: Text('USD ${game['normalPrice']}'),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(game['thumb'])
                          ),
                        ),
                      );
                    }
                  ),
                )
              )
                ])
            );
          case StatusApp.error:
            return const Center(
                child: Text("error")
              );
        }
        return const Text("Erro desconhecido");
      }
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
                  children: steamGamesInfo.map((item) {
              
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
