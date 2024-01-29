import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
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
        _authCtrl.setBStepper(1);
        navigateBack(context);
      },
      body: ListView(
        shrinkWrap: true,
        children: [
          ySpace(),
          labelText(
            "Step ${_authCtrl.bStepperVal}/4",
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 16),
          getStep(),
        ],
      ),
    );
  }

  Widget getStep() {
    switch (_authCtrl.bStepperVal) {
      case 1:
        return const BStepOneOfFour();
      case 2:
        return const BStepTwoOfFour();
      case 3:
        return const BStepThreeOfFour();
      case 4:
        return const BStepFourOfFour();
      default:
        return const BStepOneOfFour();
    }
  }
}
