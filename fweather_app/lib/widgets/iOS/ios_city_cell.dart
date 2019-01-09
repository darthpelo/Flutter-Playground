import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:fweather_app/model.dart';
import 'package:fweather_app/services/fetchModel.dart';
import 'package:fweather_app/widgets/city_cell.dart';
import 'package:fweather_app/widgets/activity_indicator.dart';

class IOSCityCell extends StatelessWidget {
  final ValueChanged<String> onRemoved;
  final String cityName;

  IOSCityCell({Key key, this.cityName, this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: FutureBuilder<CityForecast>(
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
                      onRemoved(cityName);
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
                        onRemoved(cityName);
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
}
