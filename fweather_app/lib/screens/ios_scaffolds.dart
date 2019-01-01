import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:fweather_app/model.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';
import 'package:fweather_app/widgets/ios_forecast_list.dart';
import 'package:fweather_app/widgets/ios_search_list.dart';

enum Mode { search, detail }

class IOSScaffolds extends StatelessWidget {
  final String title;
  final Mode mode;

  IOSScaffolds({this.title, this.mode});

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case Mode.detail:
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
      case Mode.search:
        return CupertinoPageScaffold(
          child: IOSCitySearch(),
        );
    }
  }
}
