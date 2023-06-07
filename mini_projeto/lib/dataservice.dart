import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum StatusApp{idle,loading,ready,error}

var estadoAplicativo = {
  'status':StatusApp.idle,
};
class DataService{
  final ValueNotifier<Map<String,dynamic>> gameStateNotifier = ValueNotifier(estadoAplicativo);



  Future<void> fetchFreeGamesData() async {
    try {
      gameStateNotifier.value = {
        'status': StatusApp.loading
      };
      final response = await http.get(Uri.parse('https://www.freetogame.com/api/games'));

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