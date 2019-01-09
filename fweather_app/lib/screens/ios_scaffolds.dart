import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:fweather_app/model.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';
import 'package:fweather_app/widgets/iOS/ios_forecast_list.dart';
import 'package:fweather_app/widgets/iOS/ios_search_list.dart';
import 'package:fweather_app/utils.dart';

class CupertinoScaffolds extends StatelessWidget {
  final String title;
  final Mode mode;

  CupertinoScaffolds({this.title, this.mode});

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case Mode.detail:
        return CupertinoPageScaffold(
            child: FutureBuilder<Forecast>(
          future: fetchCityForecast(http.Client(), title),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              return CupertinoForecastList(forecast: snapshot.data, title: title);
            } else {
              return Center(child: ActivityIndicator());
            }
          },
        ));
      case Mode.search:
        return CupertinoPageScaffold(
          child: CupertinoCitySearch(title: title,),
        );
    }
  }
}
