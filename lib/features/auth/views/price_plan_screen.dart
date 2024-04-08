import 'dart:io';

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/talent_auth/components/price_plan_card.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/paystack_webview.dart';

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
              features: Constants.proFeatures,
              onTap: () => _paystackPayment(
                  planIndex == 0 ? talentMonthlySub : talentYearlySub),

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
              features: Constants.businessFeatures,
              onTap: () => _paystackPayment(
                  planIndex == 0 ? busMonthlySub : busYearlySub),
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

  _paystackPayment(String type) async {
    var ref =
        "${Platform.isIOS ? "Ios" : "Android"}_${DateTime.now().microsecondsSinceEpoch}";
    // var ref = "t5o5vnfu13";

    try {
      // Make the call to the API, get the auth token.
      CustomPaystackResModel? paystackRes = await _authCtrl.getPaystackAuthUrl(
        context,
        CustomPaystackModel(
          reference: ref,
          callback_url: tGMWebsite,
          // SubscriptionPlanKeys.business
          planKey: busYearlySub,
          metadata: const PaystackMetadataModel(
              cancel_action: paystackCancelActionUrl),
        ),
      );
      print("George....we here now ${paystackRes?.toJson()}");
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
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      showError(message: "Something went wrong, Try again");
    }
  }

  _onSuccessfulPaystackPayment({
    required String ref,
    required int totalAmt,
    required PaymentStatus paymentStatus,
  }) async {
    // Make the request to load the wallet...
    // bool _res = await _profileCtrl.addMoneyToWallet(
    //   amount: totalAmt,
    //   paymentStatus: paymentStatus,
    //   paystackTransactionId: ref,
    // );

    // if (_res && mounted) {
    //   // Money was added successfully

    //   showSuccess(
    //     message: "Payment Successful",
    //   );
    // }
  }
}
