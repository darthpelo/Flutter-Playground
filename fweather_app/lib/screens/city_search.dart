import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:fweather_app/utils.dart';
import 'package:fweather_app/screens/ios_scaffolds.dart';
import 'package:fweather_app/screens/android_scaffolds.dart';

class CitySearchScreen extends StatelessWidget {
  CitySearchScreen({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoScaffolds(title: 'Home', mode: Mode.search,);
    } else {
      return MaterialScaffolds(title: 'Home', mode: Mode.search,);
    }
  }
}

