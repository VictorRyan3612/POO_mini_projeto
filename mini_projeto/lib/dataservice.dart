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
  var url = 'https://www.freetogame.com/api/games?';
  var url2 = 'https://www.cheapshark.com/api/1.0/deals?storeID=1';



  String parametros(String urlInicial){
    return urlFinal = urlInicial;
  }


  Future<void> fetchFreeGamesData({String filter = '', String ordem = ''}) async {
    try {
      gameStateNotifier.value = {
        'status': StatusApp.loading
      };
      var response = null;

      if (filter != ''){
        url = parametros(url + '&category=$filter&');
      }

      if (ordem != ''){
        url = parametros (url + '&sort-by=$ordem&');
      }
      

      response = await http.get(Uri.parse('$url'));
      
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

      var response = null;


      if (filter != ''){
        url2 = parametros(url2 + '&$filter=$valor&');
      }

      if (ordem != ''){
        url2 = parametros (url2 + '&sortBy=$ordem');
      }
      
      print(url2);
      response = await http.get(Uri.parse('$url2'));

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