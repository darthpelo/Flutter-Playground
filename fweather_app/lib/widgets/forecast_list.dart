import 'package:fweather_app/model.dart';
import 'package:flutter/material.dart';
import 'package:fweather_app/utils.dart';

class ForecastList extends StatelessWidget {
  final Forecast forecast;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(color: Colors.lightBlue, fontSize: 12.0);

  ForecastList({Key key, this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 39,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildRow(forecast.forecastList[index]);
        });
  }

  Widget _buildRow(ForecastData data) {
    return ListTile(
        title: Text(
          readTimestamp(data.timeStamp) + ' ' + data.weather.description,
          style: _biggerFont,
        ),
        subtitle: Text(data.mainInformation.temp + ' ℃',
            style: _smallerFont));
  }
}
