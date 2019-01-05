import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:fweather_app/services/storage.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/city_row.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';

class MaterialCitySearch extends StatefulWidget {
  @override
  _MaterialCitySearchState createState() => _MaterialCitySearchState();
}

class _MaterialCitySearchState extends State<MaterialCitySearch> {
  List<String> _cities = [];

  @override
  void initState() {
    super.initState();

    _updateSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await cityPrediction(context);

          _updateSearch(result);
        },
        tooltip: 'Add City',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _cities.length * 2,
        itemBuilder: (context, idx) {
          if (idx.isOdd)
            return Divider(
              color: Colors.black54,
            );

          final index = idx ~/ 2;
          final cityName = _cities[index];

          return FutureBuilder<CityForecast>(
              future: fetchCity(http.Client(), cityName),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.hasData) {
                  return new Slidable(
                    key: new Key(cityName),
                    child: CityRow(
                      cityForecast: snapshot.data,
                    ),
                    slideToDismissDelegate: new SlideToDismissDrawerDelegate(
                      onDismissed: (actionType) {
                        _deleteCity(cityName);
                      },
                    ),
                    delegate: new SlidableDrawerDelegate(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      new IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          _deleteCity(cityName);
                        },
                      ),
                    ],
                  );
                } else {
                  return ActivityIndicator();
                }
              });
        });
  }

  void _updateSearchList() {
    loadCities().then((onValue) {
      _reloadData(onValue);
    });
  }

  void _updateSearch(String result) {
    addCity(result).then((newCities) {
      _reloadData(newCities);
    });
  }

  void _deleteCity(String name) {
    removeCity(name).then((newCities) {
      _reloadData(newCities);
    });
  }

  void _reloadData(List<String> newCities) {
    setState(() {
      _cities = newCities;
    });
  }
}
