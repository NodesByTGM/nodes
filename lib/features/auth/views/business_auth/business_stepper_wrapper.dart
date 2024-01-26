import 'package:nodes/features/auth/views/business_auth/components/b_step_four_of_four.dart';
import 'package:nodes/features/auth/views/business_auth/components/b_step_four_of_four.dart';
import 'package:nodes/features/auth/views/business_auth/components/b_step_one_of_four.dart';
import 'package:nodes/features/auth/views/business_auth/components/b_step_three_of_four.dart';
import 'package:nodes/features/auth/views/business_auth/components/b_step_two_of_four.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class BusinessStepperWrapperScreen extends StatefulWidget {
  const BusinessStepperWrapperScreen({Key? key}) : super(key: key);

  static const String routeName = "/businessStepperWrapperScreen";

  @override
  State<BusinessStepperWrapperScreen> createState() =>
      _BusinessStepperWrapperScreen();
}

// Pass data, email etc...
class _BusinessStepperWrapperScreen
    extends State<BusinessStepperWrapperScreen> {
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
      actions: [
        GestureDetector(
          onTap: () {},
          child: subtext(
            'Log In',
            fontSize: 14,
            color: PRIMARY,
            textDecoration: TextDecoration.underline,
          ),
        ),
        xSpace(width: 10)
      ],
      body: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ySpace(),
          labelText(
            "Step 1/4",
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 16),
          // BStepOneOfFour(),
          // BStepTwoOfFour(),
          // BStepThreeOfFour(),
          BStepFourOfFour(),
        ],
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
  }
}
