import 'package:flutter/material.dart';

import 'package:fweather_app/fetchModel.dart';
import 'package:http/http.dart' as http;
import 'package:fweather_app/widgets/activity_indicator.dart';
import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/android_forecast_list.dart';

class AndroidScaffold extends StatelessWidget {
  final String title;

  AndroidScaffold({Key key, this.title});

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