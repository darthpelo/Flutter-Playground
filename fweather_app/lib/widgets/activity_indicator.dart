import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class ActivityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(child: CupertinoActivityIndicator());
    }
  }
}