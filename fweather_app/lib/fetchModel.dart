import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fweather_app/model.dart';

// A function that will convert a response body into a List<Photo>
Forecast parseCities(String responseBody) {
  final parsed = json.decode(responseBody);

  Forecast forecast = new Forecast.fromJson(parsed);
  print(forecast.runtimeType);
  return forecast;
}

Future<Forecast> fetchCities(http.Client client) async {
  final response =
  await client.get('https://api.openweathermap.org/data/2.5/forecast?appid=87503ac43c029650c30e680e36218cd5&q=amsterdam&units=metric');

  return parseCities(response.body);
}

