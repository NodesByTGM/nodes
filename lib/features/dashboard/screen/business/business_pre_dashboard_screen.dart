import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/subscriptions/screen/proceed_with_payment_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class BusinessPreDashbaordScreen extends StatefulWidget {
  const BusinessPreDashbaordScreen({super.key});

  static const String routeName = "/business_pre_dashboard_screen";

  @override
  State<BusinessPreDashbaordScreen> createState() => _BusinessPreDashbaordScreenState();
}

class _BusinessPreDashbaordScreenState extends State<BusinessPreDashbaordScreen> {
  late AuthController authCtrl;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return ListView(
      shrinkWrap: true,
      children: [
        ySpace(height: 80),
        labelText(
          "Hi ${authCtrl.currentUser.name?.split(' ').first}!",
          fontSize: 24,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
        ySpace(height: 20),
        subtext(
          "Just getting started?\nWould you like to create a business account?",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
        ySpace(height: 40),
        SvgPicture.asset(ImageUtils.spaceEmptyIcon),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SubmitBtn(
            onPressed: () {
              // Send to Subscription, proceed to sub for monthly...
              authCtrl.setSubUpgrade(
                const SubscriptionUpgrade(
                  type: KeyString.bus,
                  amount: businessMonthlyAmt,
                  period: KeyString.month,
                  features: Constants.businessFeatures,
                  isSubscribed: false,
                ),
              );
              context.read<NavController>().updatePageListStack(
                    ProceedWithPayment.routeName,
                  );
            },
            title: btnTxt(
              "Add Business account",
              WHITE,
            ),
          ),
        ),
      ],
    );
  }
}
