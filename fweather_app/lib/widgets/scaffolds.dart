import 'package:flutter/material.dart';

import 'package:fweather_app/platform.dart';
import 'package:fweather_app/screens/ios_scaffolds.dart';
import 'package:fweather_app/screens/android_scaffolds.dart';
import 'package:fweather_app/utils.dart';

class PlatformScaffold extends PlatformWidget<CupertinoScaffolds, AndroidScaffolds> {
  final String title;
  final Mode mode;

  PlatformScaffold({this.title, this.mode});

  @override
  AndroidScaffolds createAndroidWidget(BuildContext context) {
    return AndroidScaffolds(title: title, mode: mode,);
  }

  @override
  CupertinoScaffolds createIosWidget(BuildContext context) {
    return CupertinoScaffolds(title: title, mode: mode,);
  }
}