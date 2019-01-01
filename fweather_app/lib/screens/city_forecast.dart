import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:fweather_app/widgets/android_scaffold.dart';
import 'package:fweather_app/screens/ios_scaffolds.dart';

class CityForecast extends StatefulWidget {
  final String title;

  CityForecast({this.title});

  @override
  _CityForecastState createState() => _CityForecastState(title: title);
}

class _CityForecastState extends State<CityForecast> {
  final String title;

  _CityForecastState({this.title});

  @override
  Widget build(BuildContext context) {
    var _title;
    _title = title;

    if (Platform.isIOS) {
      return IOSScaffolds(title: _title, mode: Mode.detail,);
    } else {
      return AndroidScaffold(
        title: _title,
      );
    }
  }
}
