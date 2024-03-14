import 'package:flutter/material.dart';
import 'package:nodes/utilities/utils/utils.dart';

Text labelText(
  String label, {
  Color? color,
  TextAlign? textAlign,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow? overflow,
  double? letterSpacing,
  TextDecoration textDecoration = TextDecoration.none,
  double height = 1.2,
  int? maxLine,
  String? fontFamily = FontFamily,
}) {
  return Text(
    label,
    textScaleFactor: 1.0,
    textAlign: textAlign,
    overflow: overflow,
    softWrap: true,
    maxLines: maxLine,
    style: TextStyle(
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 16,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      height: height,
      fontFamily: fontFamily,
    ),
  );
}

Text titleText(String label, {TextAlign? textAlign, Color? color}) {
  return labelText(
    label,
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 17,
    textAlign: textAlign,
  );
}

Text subtext(
  String label, {
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  TextDecoration? textDecoration,
  double? fontSize,
  int? maxLines,
  TextOverflow? overflow,
  double height = 1.5,
  String? fontFamily = FontFamily,
}) {
  return Text(
    label,
    textScaleFactor: 1.0,
    textAlign: textAlign,
    softWrap: true,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      color: color ?? const Color(0xff212121),
      fontSize: fontSize ?? 15,
      fontWeight: fontWeight ?? FontWeight.w400,
      decoration: textDecoration,
      height: height,
      fontFamily: fontFamily,
    ),
  );
}
