import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:fweather_app/screens/city_search.dart';
import 'package:fweather_app/screens/city_forecast.dart';

void main() => runApp(RoutesWidget());

class RoutesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Forecast",
        initialRoute: '/',
        routes: {
          '/': (context) => MyApp(),
          '/forecast': (context) => CityForecastScreen(),
        },
      );
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Forecast';

    return MaterialApp(
      title: appTitle,
      home: CitySearchScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
        primaryColorDark: Colors.deepOrangeAccent,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
    );
  }
}
