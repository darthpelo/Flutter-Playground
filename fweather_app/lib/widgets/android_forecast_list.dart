import 'package:flutter/material.dart';

import 'package:fweather_app/services/fetchModel.dart';
import 'package:http/http.dart' as http;
import 'package:fweather_app/widgets/activity_indicator.dart';
import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/forecast_list.dart';

class MaterialForecastList extends StatelessWidget {
  final String title;

  MaterialForecastList({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<Forecast>(
        future: fetchCities(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          if (snapshot.hasData) {
            return ForecastList(forecast: snapshot.data);
          } else {
            return Center(child: ActivityIndicator());
          }
        },
      ),
    );
  }
}