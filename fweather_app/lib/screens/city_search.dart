import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:fweather_app/fetchModel.dart';

const kGoogleApiKey = "AIzaSyCeHZxMqTNYpSP1L7CLlfuhXBnMLbkRSVQ";

class CitySearch extends StatefulWidget {
  @override
  _CitySearchState createState() => _CitySearchState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _CitySearchState extends State<CitySearch> {
  List<String> _cities = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: homeScaffoldKey,
      child: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text("Cities"),
          trailing: Material(
            child: new IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  var result = await _handlePressButton();
                  setState(() {
                    _cities.add(result);
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
                    color: Colors.transparent,
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

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<String> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: "it",
      components: [
        Component(Component.country, "it"),
        Component(Component.country, "nl")
      ],
    );

//    fetchCity(http.Client(), p.description.split(",").first);
    return p.description.split(",").first;
  }
}
