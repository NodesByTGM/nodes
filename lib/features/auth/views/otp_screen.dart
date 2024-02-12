// ignore_for_file: public_member_api_docs, sort_constructors_first
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
            fontWeight: FontWeight.w600,
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
            length: 6,
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
                ),
              ),
            ],
          ),
          ySpace(height: 40),
          Wrap(
            spacing: 2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              labelText(
                "Did you get your code?",
                fontSize: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
              GestureDetector(
                onTap: () {},
                child: labelText(
                  "Send a new code",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  color: PRIMARY,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
    navigateTo(context, "${widget.otpData.to}");
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
