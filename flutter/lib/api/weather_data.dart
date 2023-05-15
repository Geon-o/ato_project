import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WeatherDataApi {

  final _openWeatherKey = '';

  Future<dynamic> getWeatherData({
    required String lat,
    required String lon,
  }) async {
    var requestUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openWeatherKey&units=metric';
    var response = await http.get(
      Uri.parse(requestUrl)
    );

    if(response.statusCode == 200) {
      var data = response.body;
      var dataJson = jsonDecode(data);

      return dataJson;
    } else {
      debugPrint('response status code = ${response.statusCode}');
    }
  }
}
