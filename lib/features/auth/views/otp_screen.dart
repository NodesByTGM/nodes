// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:nodes/features/auth/models/register_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/pin_code.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.otpData}) : super(key: key);

  final OtpScreenData otpData;

  static const String routeName = "/otpScreen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

// Pass data, email etc...
class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  late CountdownTimerController controller;
  int _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  int _retries = 0;

  @override
  void initState() {
    controller = CountdownTimerController(endTime: _endTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isCancel: false,
      title: Image.asset(
        ImageUtils.appIcon,
        fit: BoxFit.cover,
        height: 32,
        width: 36,
      ),
      body: Column(
        children: [
          ySpace(),
          labelText(
            "We emailed you a code",
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 8),
          subtext(
            "Enter the verification code sent to",
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 8),
          subtext(
            "${widget.otpData.email}",
            fontSize: 14,
            color: PRIMARY,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 40),
          PinCodeView(
            length: 4,
            onChanged: (val) {
              otpCode = val;
              setState(() {});
            },
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 56,
                margin: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    width: 1,
                    color: BORDER,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 24,
                  ),
                ),
              ),
              Expanded(
                child: SubmitBtn(
                  onPressed: _submit,
                  title: btnTxt(Constants.continueText, WHITE),
                  loading: context.watch<AuthController>().loading,
                ),
              ),
            ],
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelText(
                "Did you get your code?",
                fontSize: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
              xSpace(width: 10),
              CountdownTimer(
                controller: controller,
                endTime: _endTime,
                widgetBuilder: (context, timer) {
                  return Consumer<AuthController>(
                    builder: (_, model, __) {
                      return GestureDetector(
                        onTap: (timer != null) || model.verifyOTPStatus
                            ? null
                            : resendOTP,
                        child: labelText(
                          (timer != null)
                              ? "Re-send Code in ${timer.min ?? 0}:${timer.sec ?? 0}"
                              : "Send a new code",
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          color: PRIMARY,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
    // nextScreen(); // Dev Mode Testing
    // For some reasons, once an OTP is verified, I can't use it again to register the user...
    // bool done = await context.read<AuthController>().verifyOTP(
    //   {
    //     "otp": otpCode,
    //     "email": "${widget.otpData.email}",
    //   },
    // );
    // if (done && mounted) {}
    // OTP Verified
    // check where this particular screen was called from.
    // 1. if from signup, then proceed to register user.
    switch (widget.otpData.from) {
      case KeyString.talentSignupScreen:
        // Signup user...
        RegisterModel data = widget.otpData.data as RegisterModel;
        bool isDone = await context.read<AuthController>().register(
          {
            "name": data.name,
            "username": data.username,
            "dob": data.dob,
            "otp": otpCode,
            "email": "${widget.otpData.email}",
            "password": data.password
          },
        );
        if (isDone && mounted) {
          nextScreen();
        }
        break;
      default:
        // do nothing...
        showText(message: "OTP SENT");
    }
    // 2. else, do the next thing...
    // navigateTo(context, "${widget.otpData.to}");
  }

  void nextScreen() {
    navigateTo(context, "${widget.otpData.to}");
  }

  void resendOTP() async {
    closeKeyPad(context);
    bool sent =
        await context.read<AuthController>().sendOTP("${widget.otpData.email}");
    if (sent) {
      int addTime = _updateCount() * 1000 * 30;
      _endTime = DateTime.now().millisecondsSinceEpoch + addTime;
      controller = CountdownTimerController(endTime: _endTime);
      setState(() {});
    }
  }

  int _updateCount() {
    _retries = _retries + 1;
    return _retries;
  }
}

class OtpScreenData<T> {
  final String? from;
  final String? to;
  final String? email;
  final T? data;
  OtpScreenData({
    this.from,
    this.to,
    this.email,
    this.data,
  });
}
