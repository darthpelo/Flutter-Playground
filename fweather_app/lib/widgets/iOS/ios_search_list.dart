import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:fweather_app/services/storage.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/widgets/cellDivider.dart';
import 'ios_city_cell.dart';
import 'package:fweather_app/widgets/list_empty.dart';

class CupertinoCitySearch extends StatefulWidget {
  final String title;

  CupertinoCitySearch({this.title});

  @override
  _CupertinoCitySearchState createState() =>
      _CupertinoCitySearchState(title: title);
}

class _CupertinoCitySearchState extends State<CupertinoCitySearch> {
  List<String> _cities = [];
  final String title;

  _CupertinoCitySearchState({this.title});

  @override
  void initState() {
    super.initState();

    loadCities().then((cityList) {
      _reloadData(cityList);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cities.length > 0) {
      return _buildList(context);
    } else {
      return _buildEmptyList(context);
    }
  }

  Widget _buildEmptyList(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cities"),
        trailing: _addButton(context),
      ),
      child: EmptyList(text: 'Press + to add the cities\nyou want to monitor'),
    );
  }

  Widget _buildList(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text("Cities"),
          trailing: _addButton(context),
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
              (context, idx) {
                if (idx.isOdd) return CellDivider();

                final index = idx ~/ 2;

                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: IOSCityCell(
                    cityName: _cities[index],
                    onRemoved: (name) {
                      _delete(name);
                    },
                  ),
                );
              },
              childCount: _cities.length * 2,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _addButton(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(1.0),
        child: Material(
            child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  var result = await cityPrediction(context);

                  addCity(result).then((newList) {
                    _reloadData(newList);
                  });
                })));
  }

  void _delete(String city) {
    removeCity(city).then((newList) {
      _reloadData(newList);
    });
  }

  void _reloadData(List<String> newCities) {
    setState(() {
      _cities = newCities;
    });
  }
}
