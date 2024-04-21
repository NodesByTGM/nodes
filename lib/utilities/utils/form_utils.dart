// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nodes/utilities/constants/colors.dart';
import 'package:nodes/utilities/utils/texts.dart';
import 'package:nodes/utilities/utils/utils.dart';

const FORM_STYLE = TextStyle(color: Colors.black, fontSize: 15);

class FormUtils {
  static InputDecoration formDecoration({
    String? labelText,
    String? helperText,
    Widget? suffix,
    Widget? prefix,
    String? hintText,
    String? suffixText,
    Widget? suffixIcon,
    bool isLoading = false,
    double? verticalPadding,
    Widget? prefixIcon,
    bool enabled = true,
    bool isTransparentBorder = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 16.0),
      helperText: helperText,
      helperStyle: const TextStyle(fontSize: 15.0),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14.0),
      suffix: suffix,
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
      prefix: prefix,
      alignLabelWithHint: true,
      enabled: enabled,
      suffixText: suffixText,
      suffixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: BORDER, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: isTransparentBorder ? Colors.transparent : BORDER,
          width: 1,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: isTransparentBorder ? Colors.transparent : PRIMARY,
          width: 1,
        ),
      ),
      errorStyle: const TextStyle(fontSize: 14.0, color: Colors.red),
      filled: true,
      // fillColor: Colors.grey[300], D6D6D6
      fillColor: WHITE,
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding ?? 16),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: PRIMARY,
        ),
      ),
    );
  }

  static Widget formSpacer() {
    return const SizedBox(
      height: 28.0,
    );
  }
}

class FormWithLabel extends StatelessWidget {
  const FormWithLabel({
    Key? key,
    required this.label,
    required this.form,
    this.secondaryLabel,
  }) : super(key: key);

  final String label;
  final Widget? secondaryLabel;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subtext(
              label,
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            secondaryLabel ?? Container(),
          ],
        ),
        ySpace(height: 8),
        form
      ],
    );
  }
}

class SocialsFormWithLabel extends StatelessWidget {
  const SocialsFormWithLabel({
    Key? key,
    required this.label,
    required this.form,
    this.secondaryLabel,
  }) : super(key: key);

  final String label;
  final Widget? secondaryLabel;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: BORDER,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 11,
              top: 12,
            ),
            child: labelText(
              label,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          form
        ],
      ),
    );
  }
}

class DoubleFormWithLabel extends StatelessWidget {
  const DoubleFormWithLabel({
    Key? key,
    required this.firstForm,
    required this.lastForm,
  }) : super(key: key);

  final Widget firstForm;
  final Widget lastForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: BORDER,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          firstForm,
          lastForm,
        ],
      ),
    );
  }
}
