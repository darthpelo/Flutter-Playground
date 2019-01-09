import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:fweather_app/model.dart';
import 'package:fweather_app/widgets/forecast_row.dart';

class CupertinoForecastList extends StatelessWidget {
  final Forecast forecast;
  final String title;

  CupertinoForecastList({Key key, this.forecast, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(title),
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
                if (index.isOdd)
                  return Divider(
                    indent: 20.0,
                  );
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child:
                          ForecastRow(forecast: forecast.forecastList[index]),
                    ),
                  ),
                );
              },
              childCount: 39,
            ),
          ),
        ),
      ],
    );
  }
}
