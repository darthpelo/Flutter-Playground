import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fweather_app/model.dart';

// A function that will convert a response body into a List<Photo>
List<City> parseCities(String responseBody) {
  final List parsed = json.decode(responseBody);

  return parsed.map<City>((json) => City.fromJson(json['list'])).toList();
}

Future<List<City>> fetchCities(http.Client client) async {
  final response =
  await client.get('https://api.openweathermap.org/data/2.5/forecast?appid=87503ac43c029650c30e680e36218cd5&q=milan&units=metric');

  return parseCities(response.body);
}

