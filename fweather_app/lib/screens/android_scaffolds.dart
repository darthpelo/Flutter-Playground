import 'package:flutter/material.dart';

import 'package:fweather_app/utils.dart';
import 'package:fweather_app/widgets/android_search_list.dart';
import 'package:fweather_app/widgets/android_forecast_list.dart';

class MaterialScaffolds extends StatelessWidget {
  final String title;
  final Mode mode;

  MaterialScaffolds({this.title, this.mode});

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case Mode.search:
        return MaterialCitySearch();
      case Mode.detail:
        return MaterialForecastList(title: title);
    }
  }
}