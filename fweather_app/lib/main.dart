import 'package:flutter/material.dart';

import 'package:fweather_app/screens/city_search.dart';

void main() => runApp(RoutesWidget());

class RoutesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "Forecast",
    routes: {
      "/": (_) => MyApp(),
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Forecast';

    return MaterialApp(
      title: appTitle,
//      theme: ThemeData.dark(),
      home: CitySearch(),
    );
  }
}

