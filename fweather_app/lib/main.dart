import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<City> fetchCity() async {
  final response =
  await http.get('https://api.openweathermap.org/data/2.5/weather?appid=87503ac43c029650c30e680e36218cd5&q=milan&units=metric');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return City.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class City {
  final int cityId;
  final String name;
  final String description;

  City({this.cityId, this.name, this.description});

  factory City.fromJson(Map<String, dynamic> json) {
    var temp = json['weather'];

    return City(
      cityId: json['id'],
      name: json['name'],
      description: temp[0]['description'],
    );
  }
}

void main() => runApp(MyApp(post: fetchCity()));

class MyApp extends StatelessWidget {
  final Future<City> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<City>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data.name),
                    Text(snapshot.data.description),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}