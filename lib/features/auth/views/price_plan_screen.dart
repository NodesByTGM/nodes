import 'dart:io';

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/talent_auth/components/price_plan_card.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/paystack_webview.dart';

class PricePlanScreen extends StatefulWidget {
  const PricePlanScreen({Key? key}) : super(key: key);

  static const String routeName = "pricePlanScreen";

  @override
  State<PricePlanScreen> createState() => _PricePlanScreen();
}

// Pass data, email etc...
class _PricePlanScreen extends State<PricePlanScreen> {
  late AuthController authCtrl;
  int planIndex = 0;
  double proAmt = proMonthlyAmt;
  double businessAmt = businessMonthlyAmt;

  bool subingPro = false;
  bool subingBus = false;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
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
        authCtrl.setTStepper(5);
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
                      updateAmt();
                    });
                  },
                ),
                planTabHeader(
                  title: "Yearly billing",
                  isActive: planIndex == 1,
                  onTap: () {
                    setState(() {
                      planIndex = 1;
                      updateAmt();
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
              features: Constants.standardFeatures,
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
                    formatCurrencyAmount(Constants.naira, proAmt),
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
              features: Constants.proFeatures,
              onTap: () => _paystackPayment(
                planIndex == 0 ? talentMonthlySub : talentYearlySub,
              ),

              btnText: "Subscribe now",
              // loading: authCtrl.loading,
              loading: subingPro,
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
                    formatCurrencyAmount(Constants.naira, businessAmt),
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
              // priceDescription:"For the next  ${planIndex == 0 ? '3 months' : '1 year'} and ${formatCurrencyAmount(Constants.naira, talentOngoingProPlanAmt)} after",
              priceDescription: "Get one month free if you subscribe now",
              features: Constants.businessFeatures,
              onTap: () => _paystackPayment(
                planIndex == 0 ? busMonthlySub : busYearlySub,
              ),
              btnText: "Subscribe now",
              // loading: authCtrl.loading,
              loading: subingBus,
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

  updateAmt() {
    if (planIndex == 0) {
      setState(() {
        proAmt = proMonthlyAmt;
        businessAmt = businessMonthlyAmt;
      });
    } else {
      setState(() {
        proAmt = proYearlyAmt;
        businessAmt = businessyearlyAmt;
      });
    }
  }

  submit() {
    authCtrl.setCurrentScreen(NavbarView.routeName);
    navigateAndClearAll(context, NavbarView.routeName);
    authCtrl.resetBTStepper();
    authCtrl.dummySession({
      "loggedIn": true,
    });
  }

  _paystackPayment(String plan) async {
    var ref =
        "${Platform.isIOS ? "Ios" : "Android"}_${DateTime.now().microsecondsSinceEpoch}";
    // var ref = "t5o5vnfu13";
    handleSpinnerLoader(plan: plan, state: true);
    try {
      // Make the call to the API, get the auth token.
      CustomPaystackResModel? paystackRes = await authCtrl.getPaystackAuthUrl(
        context,
        CustomPaystackModel(
          reference: ref,
          callback_url: tGMWebsite,
          // SubscriptionPlanKeys.business
          planKey: plan,
          metadata: const PaystackMetadataModel(
            cancel_action: paystackCancelActionUrl,
          ),
        ),
      );
      handleSpinnerLoader(
        plan: plan,
        state: authCtrl.loading,
      );
      if (!isObjectEmpty(paystackRes) && mounted) {
        bool res = await Navigator.of(context).push<dynamic>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => CustomPaystackWebview(
              authUrl: "${paystackRes?.authorization_url}",
              ref: ref,
            ),
          ),
        );
        if (!res && mounted) {
          // Call the verification ENDPOINT...
          _onSuccessfulPaystackPayment(ref: ref, plan: plan);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      showError(message: "Something went wrong, Try again");
    }
  }

  handleSpinnerLoader({required String plan, bool state = false}) {
    if (plan.contains(talentMonthlySub)) {
      setState(() {
        subingPro = state;
      });
    } else {
      subingBus = state;
    }
  }

  _onSuccessfulPaystackPayment({required String ref, required String plan}) async {
    bool done = await authCtrl.verifyAndUpgradeSubscription(ref: ref, plan: plan);
    if (done && mounted) {
      submit();
    } else {
      // Sorta send the ref to BE, so as to document and track this payment...
    }
  }
}

