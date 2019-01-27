import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:fweather_app/model.dart';
import 'package:fweather_app/services/keyschain.dart';

// A function that will convert a response body into a List<Photo>
Forecast _parseDetailedForecast(String responseBody) {
  final parsed = json.decode(responseBody);

  Forecast forecast = new Forecast.fromJson(parsed);

  return forecast;
}

CityForecast _parsedGeneralForecast(String responseBody) {
  final parsed = json.decode(responseBody);

  CityForecast forecast = new CityForecast.fromJson(parsed);

  return forecast;
}

Future<Forecast> fetchCityForecast(http.Client client, String cityName) async {
  final response = await client.get(
      'https://api.openweathermap.org/data/2.5/forecast?appid=87503ac43c029650c30e680e36218cd5&q=' +
          cityName +
          '&units=metric');

  return _parseDetailedForecast(response.body);
}

Future<CityForecast> fetchCityWeather(
    http.Client client, String cityName) async {
  final response = await client.get(
      'https://api.openweathermap.org/data/2.5/weather?appid=87503ac43c029650c30e680e36218cd5&q=' +
          cityName +
          '&units=metric');

  return _parsedGeneralForecast(response.body);
}

void _onError(PlacesAutocompleteResponse response) {
  print(response.errorMessage);
}

Future<String> cityPrediction(BuildContext context) async {
  // show input autocomplete with selected mode
  // then get the Prediction selected
  Prediction p = await PlacesAutocomplete.show(
    context: context,
    apiKey: getKey(),
    onError: _onError,
    mode: Mode.overlay,
    language: "system",
  );

  return p.description.split(",").first;
}
