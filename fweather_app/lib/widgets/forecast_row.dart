import 'package:flutter/material.dart';

import 'package:fweather_app/model.dart';
import 'package:fweather_app/utils.dart';

class ForecastRow extends StatelessWidget {
  final ForecastData forecast;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(color: Colors.blueGrey, fontSize: 16.0);

  ForecastRow({Key key, this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRow(forecast);
  }

  Widget _buildRow(ForecastData data) {
    return ListTile(
        title: Text(
          readTimestamp(data.timeStamp) + ' ' + data.weather.description,
          style: _biggerFont,
        ),
        subtitle: Text(data.mainInformation.temp + ' ℃', style: _smallerFont));
  }
}