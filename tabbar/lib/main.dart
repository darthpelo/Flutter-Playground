import 'package:flutter/material.dart';

import 'package:tabbar/platform_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.drag_handle,
          size: 26,
        ),
        title: Text(categories[0].label),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.binoculars,
          size: 26,
        ),
        title: Text(categories[1].label),
      ),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.home,
            size: 26,
          ),
          title: Text(categories[2].label)),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.globeAmericas,
            size: 26,
          ),
          title: Text(categories[3].label)),
    ];
  }
}

