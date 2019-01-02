import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> loadCities() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var result = prefs.getStringList('cities') ?? [];

  return result;
}

Future<List<String>> addCity(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var cities = (prefs.getStringList('cities') ?? []);
  cities.add(name);
  prefs.setStringList('cities', cities);

  return cities;
}

Future<List<String>> removeCity(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var cities = (prefs.getStringList('cities') ?? []);
  if (cities.length > 0) {
    cities.remove(name);
    prefs.setStringList('cities', cities);
  }

  return cities;
}