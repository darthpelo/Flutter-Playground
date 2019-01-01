import 'package:flutter/material.dart';

import 'package:fweather_app/model.dart';

class CityRow extends StatelessWidget {
  final CityForecast cityForecast;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(color: Colors.blueGrey, fontSize: 16.0);

  CityRow({Key key, this.cityForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRow(cityForecast);
  }

  Widget _buildRow(CityForecast data) {
    return ListTile(
        title: Text(
          data.name + ' ' + data.weather.main,
          style: _biggerFont,
        ),
        subtitle: Text(data.mainInformation.temp + ' ℃', style: _smallerFont));
  }
}