import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:fweather_app/model.dart';
import 'package:fweather_app/fetchModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Forecast';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<City>>(
        future: fetchCities(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CitiesList(cities: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CitiesList extends StatelessWidget {
  final List<City> cities;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  CitiesList({Key key, this.cities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildRow(cities[index]);
        });
  }

  Widget _buildRow(City city) {
    return ListTile(
        title: Text(
          city.name,
          style: _biggerFont,
        ),
        subtitle: Text(city.description));
  }
}
