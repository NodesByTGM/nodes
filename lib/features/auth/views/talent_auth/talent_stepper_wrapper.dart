import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
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
  late AuthController _authCtrl;
  String? otpCode;

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return AppWrapper(
      isCancel: false,
      title: Image.asset(
        ImageUtils.appIcon,
        fit: BoxFit.cover,
        height: 32,
        width: 36,
      ),
      onTap: () {
        _authCtrl.setTStepper(1);
        navigateBack(context);
      },
      body: Column(
        children: [
          ySpace(),
          labelText(
            "Step ${_authCtrl.tStepperVal}/4",
            fontSize: 18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 16),
          getStep(),
        ],
      ),
    );
  }

  Widget getStep() {
    switch (_authCtrl.tStepperVal) {
      case 1:
        return const TStepOneOfFour();
      case 2:
        return const TStepTwoOfFour();
      case 3:
        return const TStepThreeOfFour();
      case 4:
        return const TStepFourOfFour();
      default:
        return const TStepOneOfFour();
    }
  }
}
