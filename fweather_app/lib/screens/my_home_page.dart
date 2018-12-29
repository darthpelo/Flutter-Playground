import 'package:flutter/material.dart';
import 'package:fweather_app/model.dart';
import 'package:http/http.dart' as http;
import 'package:fweather_app/fetchModel.dart';
import 'package:fweather_app/widgets/forecast_list.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';
import 'package:fweather_app/widgets/ios_forecast_list.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(),
        child: FutureBuilder<Forecast>(
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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title + ' Milan'),
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
}
