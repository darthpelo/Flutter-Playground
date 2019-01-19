import 'package:flutter/material.dart';
import 'dart:io';

abstract class PlatformWidget<iOS extends Widget, android extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return createAndroidWidget(context);
    } else if (Platform.isIOS) {
      return createIosWidget(context);
    }
    return Container();
  }

  iOS createIosWidget(BuildContext context);

  android createAndroidWidget(BuildContext context);
}