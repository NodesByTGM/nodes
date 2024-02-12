import 'package:flutter/material.dart';
import 'package:nodes/utilities/constants/colors.dart';
import 'package:nodes/utilities/utils/utils.dart';

ThemeData themeData() {
  return ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    colorScheme: ColorScheme.fromSeed(
      seedColor: PRIMARY,
      // background: RED,
      // onBackground: TEAL, // Color of this on background
    ),
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: PRIMARY,
    focusColor: RED,
    fontFamily: FontFamily,

    //
    // splashColor: PRIMARY,
  );
}
