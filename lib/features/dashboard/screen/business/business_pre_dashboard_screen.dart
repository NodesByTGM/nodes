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
  State<BusinessPreDashbaordScreen> createState() =>
      _BusinessPreDashbaordScreenState();
}

class _BusinessPreDashbaordScreenState
    extends State<BusinessPreDashbaordScreen> {
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
            onPressed: showAddBusinessAccountModal,
            title: btnTxt(
              "Add Business account",
              WHITE,
            ),
          ),
        ),
      ],
    );
  }

  showAddBusinessAccountModal() async {
    showSimpleDialog(
      context: context,
      backgroundColor: Colors.white,
      dismissable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 0),

      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText("Hi ${authCtrl.currentUser.name?.split(" ").first},"),
            ySpace(height: 10),
            subtext(
              "To add a business a account, you will need to upgrade your current plan to the business plan",
              height: 1.5,
            ),
            ySpace(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlineBtn(
                    onPressed: () {
                      navigateBack(context);
                    },
                    borderColor: BLACK,
                    child: btnTxt("Cancel"),
                  ),
                ),
                xSpace(width: 16),
                Expanded(
                  child: SubmitBtn(
                    onPressed: () {
                      navigateBack(context);
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
                      "Upgrade Plan",
                      WHITE,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // child: Container(
      //   height: 200,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       labelText("Hi <insert user firstname>!"),
      //       labelText(
      //           "To add a business a account, you will need to upgrade your current plan to the business plan"),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: OutlineBtn(
      //               onPressed: () {
      //                 navigateBack(context);
      //               },
      //               child: btnTxt("Cancel"),
      //             ),
      //           ),
      //           xSpace(width: 10),
      //           SubmitBtn(
      //             onPressed: () {
      //               // Send to Subscription, proceed to sub for monthly...
      //               authCtrl.setSubUpgrade(
      //                 const SubscriptionUpgrade(
      //                   type: KeyString.bus,
      //                   amount: businessMonthlyAmt,
      //                   period: KeyString.month,
      //                   features: Constants.businessFeatures,
      //                   isSubscribed: false,
      //                 ),
      //               );
      //               context.read<NavController>().updatePageListStack(
      //                     ProceedWithPayment.routeName,
      //                   );
      //             },
      //             title: btnTxt("Upgrade Plan"),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
