import 'dart:convert';

import 'package:covid_test_api_app/Services/Utils/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/WordStateModel.dart';

class StateServices {
  Future<WordStateModel> fetchWordData() async {
    final response = await http.get(Uri.parse(AppUrl.worldUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WordStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesData() async {
    final response = await http.get(Uri.parse(AppUrl.countriesUrl));
    var data;
    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
