import 'package:fweather_app/model.dart';
import 'package:flutter/material.dart';
import 'package:fweather_app/widgets/forecast_row.dart';

class ForecastList extends StatelessWidget {
  final Forecast forecast;

  ForecastList({Key key, this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: forecast.forecastList.length,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return ForecastRow(forecast: forecast.forecastList[index]);
        });
  }
}
