import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fweather_app/platform.dart';

class PlatformProgress extends PlatformWidget<CupertinoActivityIndicator,
    CircularProgressIndicator> {
  PlatformProgress();

  @override
  CircularProgressIndicator createAndroidWidget(BuildContext context) {
    return CircularProgressIndicator();
  }

  @override
  CupertinoActivityIndicator createIosWidget(BuildContext context) {
    return CupertinoActivityIndicator();
  }
}