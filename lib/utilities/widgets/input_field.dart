// ignore_for_file: constant_identifier_names

import 'package:nodes/utilities/constants/exported_packages.dart';

const FORM_STYLE = TextStyle(color: PRIMARY, fontSize: 15);

class FormUtils {
  static InputDecoration formDecoration(
      {String? labelText,
      String? helperText,
      Widget? suffix,
      Widget? prefix,
      String? hintText,
      String? suffixText,
      Widget? suffixIcon,
      bool isLoading = false,
      double? verticalPadding,
      Widget? prefixIcon,
      bool enabled = true}) {
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: BORDER, width: 1),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: BORDER, width: 1),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: PRIMARY, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: ACTIVE_LABEL, width: 1),
      ),
      errorStyle: const TextStyle(fontSize: 14.0, color: PRIMARY),
      filled: true,
      fillColor: Colors.white24,
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

  static InputDecoration pinInputDecoration() {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );
    return const InputDecoration(
      errorStyle: TextStyle(
        fontSize: 14.0,
      ),
      border: border,
      focusedErrorBorder: border,
      contentPadding: EdgeInsets.all(0),
      enabledBorder: border,
      counterText: "",
      enabled: false,
      errorBorder: border,
      focusedBorder: border,
    );
  }

  static InputDecoration searchInputDecorator({
    String? placeHolder,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      hintText: placeHolder ?? "Try ‘don jazzy’",
      suffixIcon: suffixIcon,
      prefixIcon: const Icon(
        Icons.search,
        size: 22,
        color: PRIMARY,
      ),
      hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 0)),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  static Widget formSpacer() {
    return const SizedBox(
      height: 28.0,
    );
  }
}

class FormLabel extends StatefulWidget {
  final String label;
  final Color? color;
  final String? hint;

  const FormLabel({Key? key, required this.label, this.color, this.hint})
      : super(key: key);

  @override
  _FormLabelState createState() => _FormLabelState();
}

class _FormLabelState extends State<FormLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            subtext(
              widget.label,
              fontSize: 13,
              color: widget.color ?? FORM_TEXT,
              fontWeight: FontWeight.w500,
            ),
            xSpace(width: 8),
          ],
        ),
      ],
    );
  }
}

class SectionDivider extends StatelessWidget {
  final String label;

  const SectionDivider({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Expanded(child: Divider()),
      xSpace(width: 5),
      subtext(label, fontSize: 12, color: GRAY),
      xSpace(width: 5),
      const Expanded(child: Divider()),
    ]);
  }
}
