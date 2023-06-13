import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mini_projeto/dataservice.dart';



@immutable
class MyFreeGamesForm extends HookWidget {
  
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
                value: '',
                child: Text('Cancelar filtro'),
              ),
              DropdownMenuItem<String>(
                value: 'racing',
                child: Text('Racing'),
              ),
              DropdownMenuItem<String>(
                value: 'shooter',
                child: Text('Shooter'),
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
class MyFreeGamesFormSort extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Ordenar por'),
            onChanged: (ordenar) {
              dataService.fetchFreeGamesData(ordem: ordenar.toString());
            },
            
            items: const [
              DropdownMenuItem<String>(
                value: '',
                child: Text('Cancelar filtro'),
              ),
              DropdownMenuItem<String>(
                value: 'alphabetical',
                child: Text('alphabetical'),
              ),
              DropdownMenuItem<String>(
                value: 'popularity',
                child: Text('popularity'),
              ),
              DropdownMenuItem<String>(
                value: 'release-date',
                child: Text('release-date'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@immutable
class MySteamFormSort extends HookWidget {
  
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
                value: '',
                child: Text('Cancelar ordenação'),
              ),
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

class MySteamFormFilterDrop extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Filtrar'),
            onChanged: (filtrar) {
              dataService.fetchSalesGamesData(filter: filtrar.toString());
            },
            
            items: const [
              DropdownMenuItem<String>(
                value: '',
                child: Text('Cancelar Filtro'),
              ),
              DropdownMenuItem<String>(
                value: 'upperPrice',
                child: Text('Valor Máximo'),
              ),
              DropdownMenuItem<String>(
                value: 'lowerPrice',
                child: Text('Valor Mínimo'),
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
class MySteamFormFilterValor extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Valor'),
          )
        ],
      )
    );
  }
}