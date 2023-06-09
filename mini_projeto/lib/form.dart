import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mini_projeto/dataservice.dart';



@immutable
class MyFreeGamesForm extends HookWidget {
  const MyFreeGamesForm({super.key});

  
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
  const MyFreeGamesFormSort({super.key});

  
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


class MySteamFormFilterDrop extends HookWidget {
  const MySteamFormFilterDrop({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Filtrar'),
            onChanged: (filtrar) {
              dataService.filtroname = filtrar.toString();
              // ValueListenableBuilder(
              //   valueListenable: dataService.filtergameStateNotifier,
                // builder: (_, value, __) {
                //   value['filtro'] = filtrar;
                // }
              // );
            },
            
            items: const [
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
  const MySteamFormFilterValor({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Form(
      child:  Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Valor'),
            
            onFieldSubmitted: (valorfiltro) {
              dataService.fetchSalesGamesData(valor: valorfiltro);
            },
          )
        ],
      )
    );
  }
}

class MySteamFormSort extends HookWidget {
  const MySteamFormSort({super.key});

  
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