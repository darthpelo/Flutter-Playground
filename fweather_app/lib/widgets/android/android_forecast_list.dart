import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/widgets/progress.dart';
import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/forecast_row.dart';

class AndroidForecastList extends StatelessWidget {
  final String title;

  AndroidForecastList({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<Forecast>(
        future: fetchCityForecast(http.Client(), title),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          if (snapshot.hasData) {
            return _buildList(context, snapshot.data);
          } else {
            return Center(child: PlatformProgress());
          }
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, Forecast forecast) {
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
