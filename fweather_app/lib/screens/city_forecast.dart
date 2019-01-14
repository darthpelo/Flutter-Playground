import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:fweather_app/utils.dart';
import 'package:fweather_app/widgets/scaffolds.dart';

class CityForecastScreen extends StatelessWidget {
  final String title;

  CityForecastScreen({Key key, this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var _title;
    _title = title;

    return PlatformScaffold(title: _title, mode: Mode.detail,);
  }
}