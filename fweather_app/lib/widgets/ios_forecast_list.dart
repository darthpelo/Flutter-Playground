import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoForecastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Home'),
//              leading: Icon(CupertinoIcons.back),
            ),
            SliverPadding(
              padding: MediaQuery
                  .of(context)
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
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: index % 2 == 0 ? Colors.yellow : Colors.blue,
                        child: Center(
                          child: ListTile(
                            title: Text(index.toString()),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
          ],
        ));
  }
}