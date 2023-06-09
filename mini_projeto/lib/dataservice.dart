import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


enum StatusApp{idle,loading,ready,error}

var estadoAplicativo = {
  'status':StatusApp.idle,
};
var filterjson = {
  'status':StatusApp.idle,
  'filtro': ''
};


class DataService{
  final ValueNotifier<Map<String,dynamic>> gameStateNotifier = ValueNotifier(estadoAplicativo);
  String filtroname = '';
  
  var freetoGameURl = 'https://www.freetogame.com/api/games?';
  var saleGamesURL = 'https://www.cheapshark.com/api/1.0/deals?storeID=1';
  


  void cancelarFreeGames(){
    freetoGameURl = 'https://www.freetogame.com/api/games?';
  }
  void cancelarSaleGames(){
    saleGamesURL = 'https://www.cheapshark.com/api/1.0/deals?storeID=1';
  }



  Future<void> fetchFreeGamesData({String filter = '', String ordem = '', bool cancelar = false}) async {
    try {
      gameStateNotifier.value = {
        'status': StatusApp.loading
      };

      http.Response response;

      if (filter != ''){
        freetoGameURl = '$freetoGameURl&category=$filter';
      }
      if (ordem != ''){
        freetoGameURl = '$freetoGameURl&sort-by=$ordem';
      }
      if (cancelar == true){
        dataService.cancelarFreeGames();
      }


      response = await http.get(Uri.parse(freetoGameURl));
      final jsonResponse = jsonDecode(response.body);

      gameStateNotifier.value = {
        'status': StatusApp.ready,
        'games': jsonResponse
      } ;
    } 
    catch (error) {
      gameStateNotifier.value['status'] = StatusApp.error;
    }
  }




  Future<void> fetchSalesGamesData({String filter = '', String valor ='', String ordem = '', bool cancelar = false}) async {

    try {
      gameStateNotifier.value = {
        'status': StatusApp.loading
      };

      http.Response response;


      filter =  filtroname;
      if (valor != '' && filter != ''){
        saleGamesURL = '$saleGamesURL&$filter=$valor';
      }

      if (ordem != ''){
        saleGamesURL = '$saleGamesURL&sortBy=$ordem';
      }
      if (cancelar == true){
        dataService.cancelarSaleGames();
      }



      response = await http.get(Uri.parse(saleGamesURL));
      final jsonResponse = jsonDecode(response.body);

      gameStateNotifier.value = {
        'status': StatusApp.ready,
        'games': jsonResponse
      } ;
    } 
    catch (error) {
      gameStateNotifier.value['status'] = StatusApp.error;
    }
  }


}

final dataService = DataService();