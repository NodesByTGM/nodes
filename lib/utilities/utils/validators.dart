// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nodes/utilities/utils/enums.dart';

String? validateEmail(String? t) {
  String text = t ?? "";
  var regExp = RegExp(
    '[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\. [a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+',
    caseSensitive: false,
    multiLine: false,
  );
  if (text.isEmpty) {
    return 'Field cannot be empty!';
  } else if (!regExp.hasMatch(text)) {
    return 'invalid email address';
  }
  return null;
}

String? validatePhone(String? t) {
  String text = t ?? "";
  var regExp = RegExp(r'^[0-9]+$');
  if (text.isEmpty) {
    return 'Field cannot be empty!';
  } else if (text.length < 11 && text[0] == '0') {
    return 'Please input a valid phone number';
  } else if (!regExp.hasMatch(text)) {
    return 'Phone number invalid';
  }
  return null;
}

String? validateField(String? t) {
  String text = t ?? '';
  var regExp = RegExp(
    r'^[a-zA-Z_\-\.]+$',
    caseSensitive: false,
    multiLine: false,
  );
  if (text.isEmpty) {
    return 'Field cannot be empty!';
  } else if (!regExp.hasMatch(text)) {
    return 'Invalid name, only hyphens (-) allowed';
  }
  return null;
}

String? validatePassword(String? value) {
  String passwordText = value ?? "";

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(
    pattern,
    caseSensitive: false,
    multiLine: false,
  );

  if (passwordText.isEmpty) {
    return 'Field cannot be empty!';
  } else if (!regExp.hasMatch(passwordText)) {
    return 'Passwords does not meet criteria!';
  }
  return null;
}

bool validateSocialMediaField({
  required String value,
  required SocialMediaTypes? type,
}) {
  switch (type) {
    case SocialMediaTypes.Instagram:
      return value.toLowerCase().contains('instagram');
    case SocialMediaTypes.Twitter:
      return value.toLowerCase().contains('twitter');
    case SocialMediaTypes.Linkedin:
      return value.toLowerCase().contains('linkedin');
    default:
      return false;
  }
}

String getNairaSign() {
  return "₦";
}

enum DialogType { ERROR, SUCCESS }

void showSnackBar(
  BuildContext context,
  String message, {
  DialogType? type,
  Color backgroundColor = Colors.transparent,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: (type != null)
          ? ((type == DialogType.SUCCESS) ? Colors.green[700] : Colors.red[500])
          : backgroundColor,
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: 9 * MediaQuery.of(context).size.height / 10,
        left: 20,
        right: 20,
      ),
      duration: const Duration(
        seconds: 2,
      ),
    ),
  );
}
