import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


enum StatusApp{idle,loading,ready,error}

var estadoAplicativo = {
  'status':StatusApp.idle,
};


class DataService{
  final ValueNotifier<Map<String,dynamic>> gameStateNotifier = ValueNotifier(estadoAplicativo);
  String urlFinal ='';
  var freetoGameURl = 'https://www.freetogame.com/api/games?';
  var url2 = 'https://www.cheapshark.com/api/1.0/deals?storeID=1';

  void cancelar(){
    freetoGameURl = 'https://www.freetogame.com/api/games?';
  }


  Future<void> fetchFreeGamesData({String filter = '', String ordem = '', bool cancelar = false}) async {
    try {
      gameStateNotifier.value = {
        'status': StatusApp.loading
      };
      http.Response response;

      if (filter != ''){
        freetoGameURl = '$freetoGameURl&category=$filter&';
      }
      if (ordem != ''){
        freetoGameURl = '$freetoGameURl&sort-by=$ordem&';
      }
      if (cancelar == true || filter == 'cancelar'){
        dataService.cancelar();
      }
      print(freetoGameURl);
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
    print("${gameStateNotifier.value['status']}");
  }




  Future<void> fetchSalesGamesData({String filter = '', String valor ='15', String ordem = ''}) async {
    try {
      gameStateNotifier.value = {
        'status': StatusApp.loading
      };

      http.Response response;


      if (filter != ''){
        url2 = '$url2&$filter=$valor&';
      }

      if (ordem != ''){
        url2 = '$url2&sortBy=$ordem';
      }
      
      print(url2);
      response = await http.get(Uri.parse(url2));

      final jsonResponse = jsonDecode(response.body);

      gameStateNotifier.value = {
        'status': StatusApp.ready,
        'games': jsonResponse
      } ;
    } 
    catch (error) {
      gameStateNotifier.value['status'] = StatusApp.error;
    }
    print("${gameStateNotifier.value['status']}");
  }


}

final dataService = DataService();