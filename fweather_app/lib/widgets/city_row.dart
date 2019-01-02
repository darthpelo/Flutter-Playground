import 'package:flutter/material.dart';

import 'package:fweather_app/model.dart';

class CityRow extends StatelessWidget {
  final CityForecast cityForecast;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(color: Colors.blueGrey, fontSize: 16.0);

  CityRow({Key key, this.cityForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRow(cityForecast);
  }

  Widget _buildRow(CityForecast data) {
    return ListTile(title: _buildImageRow(data));
  }

  Widget _buildImageRow(CityForecast data) {
    var image = Image.network(
        'http://openweathermap.org/img/w/' + data.weather.icon + '.png');
    return Row(
      children: <Widget>[
        image,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8.0,
                    bottom: 8.0),
                child: Text(
                  data.name,
                  style: _biggerFont,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  data.mainInformation.temp + ' ℃',
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
