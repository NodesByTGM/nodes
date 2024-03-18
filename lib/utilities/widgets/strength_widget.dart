import 'package:flutter/material.dart';
import 'package:nodes/utilities/constants/colors.dart';

class StrengthWidget extends StatefulWidget {
  const StrengthWidget({
    super.key,
    required this.controller,
    required this.valueCallback,
  });

  final TextEditingController controller;
  final Function(double) valueCallback;

  @override
  State<StrengthWidget> createState() => _StrengthWidgetState();
}

class _StrengthWidgetState extends State<StrengthWidget> {
  @override
  void initState() {
    widget.controller.addListener(() {
      valueNotifier.value = checker(widget.controller.text);
    });
    super.initState();
  }

  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0);

  double checker(String input) {
    final smallReg = RegExp(r'[a-z]');
    final capitalReg = RegExp(r'[A-Z]');
    final numberReg = RegExp(r'[0-9]');
    // final specialReg = RegExp(r'[!@#\$&*~]');
    final specialReg = RegExp(r'[!@#\\$%^&*(),.?":{}|<>]');
    final lengthReg = RegExp(r'^.{8,32}$');

    double value = 0.0;

    //check length
    if (input.length > 7) {
      value += 0.2;
    }

    //check lowercase
    if (input.contains(smallReg)) {
      value += 0.2;
    }

    //check uppercase
    if (input.contains(capitalReg)) {
      value += 0.2;
    }

    //check number
    if (input.contains(numberReg)) {
      value += 0.2;
    }

    //check special
    if (input.contains(specialReg)) {
      value += 0.2;
    }

    //check if length is extra strong
    // if (value >= .8 && input.length > 12) {
    if (value >= .8 && input.contains(lengthReg)) {
      value += 0.2;
    }

    widget.valueCallback(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (BuildContext context, double value, Widget? child) {
        value = double.parse(value.toStringAsFixed(1));

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  //this is active 50% of value is greater
                  //than 0 and it is active 100% if value is greater than 0.2
                  value: value == 0.0
                      ? 0
                      : value <= 0.2
                          ? 0.5
                          : 1,
                  valueColor: const AlwaysStoppedAnimation<Color>(RED),
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: LinearProgressIndicator(
                //this is active 50% of value is equal
                //to 0.6 and it is active 100% if value is greater than 0.6
                value: value == 0.6
                    ? 0.5
                    : value >= .8
                        ? 1
                        : 0,
                valueColor: const AlwaysStoppedAnimation<Color>(YELLOW),
                minHeight: 7,
                borderRadius: BorderRadius.circular(15),
              )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: LinearProgressIndicator(
                //this is active 50% of value is equal
                //to 0.8 and it is active 100% if value is greater than 1
                value: value <= 1 && value >= .8
                    ? 0.5
                    : value >= 1
                        ? 1
                        : 0,
                valueColor: const AlwaysStoppedAnimation<Color>(PRIMARY),
                minHeight: 7,
                borderRadius: BorderRadius.circular(15),
              )),
            ],
          ),
        );
      },
    );
  }
}
