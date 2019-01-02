import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:fweather_app/services/storage.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/city_row.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';

class IOSCitySearch extends StatefulWidget {
  final String title;

  IOSCitySearch({this.title});

  @override
  _IOSCitySearchState createState() => _IOSCitySearchState(title: title);
}

class _IOSCitySearchState extends State<IOSCitySearch> {
  List<String> _cities = [];
  final String title;

  _IOSCitySearchState({this.title});

  @override
  void initState() {
    super.initState();

    _updateSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      CupertinoSliverNavigationBar(
        largeTitle: Text("Cities"),
        trailing: Material(
          child: new IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                var result = await cityPrediction(context);

                _updateSearch(result);
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
                child: _buildCell(context, _cities[index]),
              );
            },
            childCount: _cities.length,
          ),
        ),
      ),
    ]);
  }

  Widget _buildCell(BuildContext context, String cityName) {
    return new Material(
//      elevation: 2.5,
//      borderRadius: BorderRadius.circular(2.0),
      color: Colors.white,
      child: Center(
        child: FutureBuilder<CityForecast>(
            future: fetchCity(http.Client(), cityName),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              if (snapshot.hasData) {
                return new Slidable(
                  key: new Key(cityName),
                  child: CityRow(cityForecast: snapshot.data,),
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
            }),
      ),
    );
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
