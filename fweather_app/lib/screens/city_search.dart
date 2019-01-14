import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:fweather_app/utils.dart';
import 'package:fweather_app/widgets/scaffolds.dart';

class CitySearchScreen extends StatelessWidget {
  CitySearchScreen({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(title: 'Home', mode: Mode.search,);
  }
}