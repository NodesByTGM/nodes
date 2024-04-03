import 'dart:io';

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/talent_auth/components/price_plan_card.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';

class PricePlanScreen extends StatefulWidget {
  const PricePlanScreen({Key? key}) : super(key: key);

  static const String routeName = "pricePlanScreen";

  @override
  State<PricePlanScreen> createState() => _PricePlanScreen();
}

// Pass data, email etc...
class _PricePlanScreen extends State<PricePlanScreen> {
  late AuthController _authCtrl;
  int planIndex = 0;
  double talentProPlanAmt = 4900;
  double talentOngoingProPlanAmt = 7900;
  double businessPlanAmt = 19800;
  // late final PaystackPlugin paystackPlugin;

  @override
  void initState() {
    _authCtrl = locator.get<AuthController>();
    // paystackPlugin = locator.get<PaystackPlugin>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authCtrl = context.watch<AuthController>();
    return AppWrapper(
      isCancel: false,
      backgroundColor: PRIMARY,
      backBtnColor: WHITE,
      title: Image.asset(
        ImageUtils.appIcon,
        fit: BoxFit.cover,
        height: 32,
        width: 36,
        color: WHITE,
      ),
      onTap: () {
        _authCtrl.setTStepper(5);
        navigateBack(context);
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            ySpace(),
            labelText(
              "PRICING",
              fontSize: 16,
              color: WHITE,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            ySpace(height: 16),
            labelText(
              "Thank you for choosing Nodes!",
              fontSize: 20,
              color: WHITE,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            ySpace(height: 16),
            labelText(
              "Pricing plans for every budget",
              fontSize: 16,
              color: WHITE,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
            ySpace(height: 40),
            labelText(
              "Choose plan",
              fontSize: 16,
              color: WHITE,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            ySpace(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                planTabHeader(
                  title: "Monthly billing",
                  isActive: planIndex == 0,
                  onTap: () {
                    setState(() {
                      planIndex = 0;
                      yearlyPlanFn();
                    });
                  },
                ),
                planTabHeader(
                  title: "Yearly billing",
                  isActive: planIndex == 1,
                  onTap: () {
                    setState(() {
                      planIndex = 1;
                      yearlyPlanFn();
                    });
                  },
                ),
              ],
            ),
            ySpace(height: 40),
            PricePlanCard(
              type: "Standard",
              description: "Lorem Ipsum dolor sit amet",
              icon: ImageUtils.standardPlanIcon,
              price: labelText(
                "Free",
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              priceDescription: "Free/forever",
              features: const [
                "Community Engagement",
                "Networking Opportunities",
                "Stay Informed on Creative Trends",
              ],
              // onTap: pay,
              onTap: submit,
              btnText: "Continue for free",
            ),
            ySpace(height: 24),
            PricePlanCard(
              type: "Pro",
              description: "Lorem Ipsum dolor sit amet",
              icon: ImageUtils.proPlanIcon,
              price: Wrap(
                spacing: 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  labelText(
                    formatCurrencyAmount(Constants.naira, talentProPlanAmt),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  subtext(
                    "/${planIndex == 0 ? 'month' : 'year'}",
                    fontSize: 12,
                    color: GRAY,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              // priceDescription: "For the next  ${planIndex == 0 ? '3 months' : '1 year'} and ${formatCurrencyAmount(Constants.naira, talentOngoingProPlanAmt)} after",
              priceDescription: "Get one month free if you subscribe now",
              features: const [
                "Enhanced Visibility",
                "Access to Premium Jobs",
                "Expanded Project Showcase",
                "Advanced Analytics and Insights",
                "Access to GridTools Discovery Pack (Free)",
              ],
              onTap: submit,
              btnText: "Subscribe now",
            ),
            ySpace(height: 24),
            PricePlanCard(
              type: "Business",
              description: "Lorem Ipsum dolor sit amet",
              icon: ImageUtils.businessPlanIcon,
              price: Wrap(
                spacing: 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  labelText(
                    formatCurrencyAmount(Constants.naira, businessPlanAmt),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  subtext(
                    "/${planIndex == 0 ? 'month' : 'year'}",
                    fontSize: 12,
                    color: GRAY,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              priceDescription:
                  "For the next  ${planIndex == 0 ? '3 months' : '1 year'} and ${formatCurrencyAmount(Constants.naira, talentOngoingProPlanAmt)} after",
              features: const [
                "Premium Talent Pool Access",
                "Featured Job Listings",
                "Analytics and Performance Metrics",
                "Promotion and Marketing Opportunities",
                "Access to GridTools Discovery Pack (Free)",
              ],
              onTap: submit,
              btnText: "Subscribe now",
            ),
            ySpace(height: 24),
          ],
        ),
      ),
    );
  }

  GestureDetector planTabHeader({
    required String title,
    required bool isActive,
    required GestureCancelCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SvgPicture.asset(
            isActive ? ImageUtils.radioSelected : ImageUtils.radioUnselected,
          ),
          labelText(
            title,
            color: WHITE,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  yearlyPlanFn() {
    if (planIndex == 0) {
      talentProPlanAmt = 4900;
      talentOngoingProPlanAmt = 7900;
    } else {
      talentProPlanAmt = 80000;
      talentOngoingProPlanAmt = 89800;
    }
  }

  submit() {
    _authCtrl.setCurrentScreen(NavbarView.routeName);
    navigateAndClearAll(context, NavbarView.routeName);
    _authCtrl.resetBTStepper();
    _authCtrl.dummySession({
      "loggedIn": true,
    });
  }

  pay() {
    var _ref =
        "${Platform.isIOS ? "Ios" : "Android"}_${DateTime.now().microsecondsSinceEpoch}";
    FlutterPaystackPlus.openPaystackPopup(
      customerEmail: "g.ikwegbu@gmail.com",
      context: context,
      currency: KeyString.ngn,
      secretKey: PAYSTACK_PRO_PAN_SK,
      amount: (200 * 100).toString(),
      reference: _ref,
      callBackUrl: "[GET IT FROM YOUR PAYSTACK DASHBOARD]",
      onClosed: () {
        debugPrint('Could\'nt finish payment');
      },
      onSuccess: () async {
        debugPrint('successful payment');
      },
    );
  }
}
