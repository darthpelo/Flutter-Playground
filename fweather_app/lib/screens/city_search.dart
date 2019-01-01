import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:fweather_app/screens/ios_scaffolds.dart';

class CitySearch extends StatelessWidget {
  CitySearch({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return IOSScaffolds(title: 'Home', mode: Mode.search,);
  }
}

