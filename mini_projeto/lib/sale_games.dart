import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';



class SaleGames extends HookWidget {
const SaleGames({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogos em Promoção'),
      ),
      body: Container(),
    );
  }
}