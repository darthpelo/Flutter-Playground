import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:fweather_app/services/storage.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/city_cell.dart';
import 'package:fweather_app/widgets/progress.dart';
import 'package:fweather_app/widgets/cellDivider.dart';
import 'package:fweather_app/widgets/list_empty.dart';

class MaterialCitySearch extends StatefulWidget {
  @override
  _MaterialCitySearchState createState() => _MaterialCitySearchState();
}

class _MaterialCitySearchState extends State<MaterialCitySearch> {
  List<String> _cities = [];

  @override
  void initState() {
    super.initState();

//    loadCities().then((cityList) {
//      _reloadData(cityList);
//    });
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

          addCity(result).then((newList) {
            _reloadData(newList);
          });
        },
        tooltip: 'Add City',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (_cities.length > 0) {
      return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _cities.length * 2,
          itemBuilder: (context, idx) {
            if (idx.isOdd) return CellDivider();

            final index = idx ~/ 2;
            final cityName = _cities[index];

            return FutureBuilder<CityForecast>(
                future: fetchCityWeather(http.Client(), cityName),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    return new Slidable(
                      key: new Key(cityName),
                      child: CityCell(
                        cityForecast: snapshot.data,
                      ),
                      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
                        onDismissed: (actionType) {
                          removeCity(cityName).then((newList) {
                            _reloadData(newList);
                          });
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
                            removeCity(cityName).then((newList) {
                              _reloadData(newList);
                            });
                          },
                        ),
                      ],
                    );
                  } else {
                    return PlatformProgress();
                  }
                });
          });
    } else {
      return EmptyList(text: 'Press + to add the cities\nyou want to monitor',);
    }
  }

  void _reloadData(List<String> newCities) {
    setState(() {
      _cities = newCities;
    });
  }
}
