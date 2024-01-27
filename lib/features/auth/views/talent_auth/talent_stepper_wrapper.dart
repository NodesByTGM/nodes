import 'package:nodes/features/auth/views/talent_auth/components/t_step_four_of_four.dart';
import 'package:nodes/features/auth/views/talent_auth/components/t_step_one_of_four.dart';
import 'package:nodes/features/auth/views/talent_auth/components/t_step_three_of_four.dart';
import 'package:nodes/features/auth/views/talent_auth/components/t_step_two_of_four.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TalentStepperWrapperScreen extends StatefulWidget {
  const TalentStepperWrapperScreen({Key? key}) : super(key: key);

  static const String routeName = "/talentStepperWrapperScreen";

  @override
  State<TalentStepperWrapperScreen> createState() =>
      _TalentStepperWrapperScreen();
}

// Pass data, email etc...
class _TalentStepperWrapperScreen extends State<TalentStepperWrapperScreen> {
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
      body: Column(
        children: [
          ySpace(),
          labelText(
            "Step 1/4",
            fontSize: 18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 16),
          // TStepOneOfFour(),
          // TStepTwoOfFour(),
          // TStepThreeOfFour(),
          TStepFourOfFour(),
        ],
      ),
    );
  }

  void _submit() async {
    closeKeyPad(context);
  }
}
