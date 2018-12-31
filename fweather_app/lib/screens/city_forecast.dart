import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:fweather_app/widgets/android_scaffold.dart';
import 'package:fweather_app/widgets/ios_scaffold.dart';

class CityForecast extends StatelessWidget {
  final String title;

  CityForecast({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _title = title + ' Milan';

    if (Platform.isIOS) {
      return IOSScaffold(title: _title);
    } else {
      return AndroidScaffold(
        title: _title,
      );
    }
  }
}
