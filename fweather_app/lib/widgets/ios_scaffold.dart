import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:fweather_app/model.dart';
import 'package:fweather_app/fetchModel.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';
import 'package:fweather_app/widgets/ios_forecast_list.dart';

class IOSScaffold extends StatelessWidget {
  final String title;

  IOSScaffold({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: FutureBuilder<Forecast>(
      future: fetchCities(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        if (snapshot.hasData) {
          return IOSForecastList(forecast: snapshot.data, title: title);
        } else {
          return Center(child: ActivityIndicator());
        }
      },
    ));
  }
}
