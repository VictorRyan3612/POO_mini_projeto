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
            ],
          ),
        ],
      ),
    );
  }
}