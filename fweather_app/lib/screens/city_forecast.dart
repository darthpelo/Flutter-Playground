import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:fweather_app/utils.dart';
import 'package:fweather_app/widgets/android/android_forecast_list.dart';
import 'package:fweather_app/screens/ios_scaffolds.dart';

class CityForecastScreen extends StatelessWidget {
  final String title;

  CityForecastScreen({Key key, this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var _title;
    _title = title;

    if (Platform.isIOS) {
      return CupertinoScaffolds(title: _title, mode: Mode.detail,);
    } else {
      return AndroidForecastList(
        title: _title,
      );
    }
  }
}