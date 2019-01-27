import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

final CollectionReference citiesCollection =
    Firestore.instance.collection('cities');

Future<List<DocumentSnapshot>> loadRemote() async {
  final response = await citiesCollection.getDocuments();

  return response.documents;
}

void create(String title, int index) async {
  final response = await Firestore.instance
      .collection("cities")
      .document('$index')
      .setData({"name": title});

  return response;
}

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

class Record {
  final String name;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "$name";
}
