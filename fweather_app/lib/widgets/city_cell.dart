import 'package:flutter/material.dart';

import 'package:fweather_app/model.dart';
import 'package:fweather_app/screens/city_forecast.dart';

class CityCell extends StatelessWidget {
  final CityForecast cityForecast;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(color: Colors.blueGrey, fontSize: 16.0);

  CityCell({Key key, this.cityForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildImageRow(context, cityForecast),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CityForecastScreen(title: cityForecast.name)));
      },
    );
  }

  Widget _buildImageRow(BuildContext context, CityForecast data) {
    return new Row(
      children: <Widget>[
        Image.network(
          'http://openweathermap.org/img/w/' + data.weather.icon + '.png',
          scale: 1.3,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  data.name,
                  style: _biggerFont,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  data.mainInformation.temp.ceilToDouble().toString() + ' ℃',
                  style: _smallerFont,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
