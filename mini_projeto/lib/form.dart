import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mini_projeto/dataservice.dart';



@immutable
class MyCustomForm extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Filtro de Gênero'),
            onChanged: (filtro) {
              dataService.fetchFreeGamesData(filter: filtro.toString());
            },
            
            items: const [
              DropdownMenuItem<String>(
                value: 'racing',
                child: Text('Racing'),
              ),
              DropdownMenuItem<String>(
                value: 'shooter',
                child: Text('Shooter'),
              ),
              DropdownMenuItem<String>(
                value: 'action',
                child: Text('Action'),
              ),
              DropdownMenuItem<String>(
                value: 'sci-fi',
                child: Text('Sci-fi'),
              ),
              DropdownMenuItem<String>(
                value: 'fighting',
                child: Text('Fighting'),
              ),
              DropdownMenuItem<String>(
                value: 'open-world',
                child: Text('Mundo Aberto'),
              ),
              DropdownMenuItem<String>(
                value: 'anime',
                child: Text('Anime'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@immutable
class MySteamForm extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Ordenar'),
            onChanged: (ordenar) {
              dataService.fetchSalesGamesData(ordem: ordenar.toString());
            },
            
            items: const [
              DropdownMenuItem<String>(
                value: 'Title',
                child: Text('Titulo'),
              ),
              DropdownMenuItem<String>(
                value: 'Price',
                child: Text('Preço'),
              ),
              DropdownMenuItem<String>(
                value: 'Metacritic',
                child: Text('Metacritic'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}