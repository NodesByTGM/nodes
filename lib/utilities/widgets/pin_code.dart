import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:pinput/pinput.dart';

class PinCodeView extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String)? onCompleted;
  final int length;
  final bool coloredBg;
  final bool obscureText;
  final String errorMsg;
  final TextInputType inputType;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const PinCodeView({
    Key? key,
    required this.onChanged,
    this.onCompleted,
    this.length = 4,
    this.coloredBg = false,
    this.onSaved,
    this.validator,
    this.obscureText = true,
    this.errorMsg = 'Invalid Code',
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  _PinCodeViewState createState() => _PinCodeViewState();
}

class _PinCodeViewState extends State<PinCodeView> {
  bool hasError = false;
  final pinController = TextEditingController();

  late String _errorMsg;
  late TextInputType _inputType;
  late FocusNode _pinPutFocusNode;

  @override
  void initState() {
    _pinPutFocusNode = FocusNode();
    if (mounted) {
      _inputType = widget.inputType;
      _errorMsg = widget.errorMsg;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = PRIMARY;
    const fillColor = WHITE;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: BORDER),
      ),
    );
    return SizedBox(
      width: screenWidth(context),
      child: Pinput(
        obscureText: true,
        validator: widget.validator ??
            (text) {
              if (isEmpty(text) || text!.length < widget.length) {
                return _errorMsg;
              }
              return null;
            },
        pinAnimationType: PinAnimationType.fade,
        listenForMultipleSmsOnAndroid: true,
        hapticFeedbackType: HapticFeedbackType.lightImpact,

        // onSaved: widget.onSaved,
        focusNode: _pinPutFocusNode,
        keyboardType: _inputType,
        length: widget.length,
        // inputDecoration: FormUtils.pinInputDecoration(),
        onClipboardFound: (value) {
          debugPrint('onClipboardFound: $value');
          pinController.setText(value);
        },
        onCompleted: (pin) {
          if (!isObjectEmpty(widget.onCompleted)) {
            widget.onCompleted!(pin);
            debugPrint('onCompleted: $pin');
          }
        },
        onChanged: (value) {
          widget.onChanged(value);
          debugPrint('onChanged: $value');
        },

        // eachFieldHeight: 44,
        // eachFieldWidth: 44,
        preFilledWidget: subtext(widget.obscureText ? '-' : ''),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: fillColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinPutFocusNode.dispose();
    pinController.dispose();

    super.dispose();
  }
}
