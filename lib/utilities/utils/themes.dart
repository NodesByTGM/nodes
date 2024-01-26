import 'package:flutter/material.dart';
import 'package:nodes/utilities/constants/colors.dart';

ThemeData themeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: PRIMARY,
    focusColor: RED,
  );
}
