import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fweather_app/keyschain.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CitySearch extends StatefulWidget {
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  List<String> _cities = [];

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text("Cities"),
          trailing: Material(
            child: new IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  var result = await _handlePressButton();
                  setState(() {
                    _addCity(result);
                  });
                }),
          ),
        ),
        SliverPadding(
          padding: MediaQuery.of(context)
              .removePadding(
                removeTop: true,
                removeLeft: true,
                removeRight: true,
              )
              .padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.cyanAccent,
                    child: Center(
                      child:
                      ListTile(
                          title: Text(_cities[index])),
                    ),
                  ),
                );
              },
              childCount: _cities.length,
            ),
          ),
        ),
      ]),
    );
  }

  _loadCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cities= (prefs.getStringList('cities') ?? []);
    });
  }

  void _addCity(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cities = (prefs.getStringList('cities') ?? []);
      _cities.add(name);
      prefs.setStringList('cities', _cities);
    });
  }
  
  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }

  Future<String> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: getKey(),
      onError: onError,
      mode: Mode.overlay,
      language: "system",
    );
    
    return p.description.split(",").first;
  }
}
