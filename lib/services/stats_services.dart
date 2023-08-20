import 'dart:convert';

import 'package:covid_app/model/world_stats_model.dart';
import 'package:covid_app/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  static Future<WorldStats> getWorldStatData() async {
    try {
  final response = await http.get(Uri.parse(AppUrls.worldStatsApi));
  var data = jsonDecode(response.body);
  
  if (response.statusCode == 200) {
   return WorldStats.fromJson(data);
  } 
  else{
     throw Exception('API request failed with status code: ${response.statusCode}');
  }
} on Exception catch (e) {
  throw Exception('An error occurred: $e');
}
  }

  static Future<List<dynamic>> getCountriesList() async {
    try {
  final response = await http.get(Uri.parse(AppUrls.countriesList));
  var data = jsonDecode(response.body);
  
  if (response.statusCode == 200) {
   return data;
  } 
  else{
     throw Exception('API request failed with status code: ${response.statusCode}');
  }
} on Exception catch (e) {

  throw Exception('An error occurred: $e');
}
  }
}
