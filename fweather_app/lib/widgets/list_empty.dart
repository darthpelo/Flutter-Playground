import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String text;

  EmptyList({Key key, this.text}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}