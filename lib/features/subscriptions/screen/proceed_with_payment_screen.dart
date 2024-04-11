import 'dart:io';

import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/subscriptions/components/subscription_table.dart';
import 'package:nodes/features/subscriptions/screen/subscription_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/paystack_webview.dart';

class ProceedWithPayment extends StatefulWidget {
  const ProceedWithPayment({super.key});

  // Accept the data... but from STATE

  static const String routeName = "/proceed_with_payment_screen";

  @override
  State<ProceedWithPayment> createState() => _ProceedWithPaymentState();
}

class _ProceedWithPaymentState extends State<ProceedWithPayment> {
  late AuthController authCtrl;
  late NavController navCtrl;
  late SubscriptionUpgrade subUpgrade;
  bool seeMore = false;
  bool isSubscribed = false;

  // Send the subscription type, month or year, amount, description.

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    navCtrl = locator.get<NavController>();
    subUpgrade = authCtrl.subUpgrade;
    isSubscribed = subUpgrade.isSubscribed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    navCtrl = context.watch<NavController>();
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 32, bottom: 150),
          children: [
            labelText(
              isSubscribed
                  ? "Manage your subscription here"
                  : "Proceed with payment",
              height: 2,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            ySpace(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.7,
                  color: BORDER,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText(
                    "${subUpgrade.type}",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  ySpace(height: 16),
                  subtext(
                    subUpgrade.description ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  ySpace(height: 32),
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labelText(
                        formatCurrencyAmount(
                            Constants.naira, subUpgrade.amount!),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: PRIMARY,
                      ),
                      subtext(
                        "/${subUpgrade.period}",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  ExpandableSection(
                    expand: seeMore,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customDivider(),
                        labelText(
                          'Features:',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        ySpace(height: 24),
                        ...getFeatures(),
                      ],
                    ),
                  ),
                  ySpace(height: 32),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          seeMore = !seeMore;
                        });
                      },
                      child: labelText(
                        seeMore ? "Collapse" : "See more",
                        color: PRIMARY,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ySpace(height: 40),
            if (isSubscribed) ...[
              // Billing History
              SubscriptionTable()
            ],
            if (!isSubscribed) ...[
              OutlineBtn(
                onPressed: () => _paystackPayment(),
                borderColor: BORDER,
                leftIcon: Image.asset(
                  ImageUtils.paystackIcon,
                  height: 24,
                ),
                loading: authCtrl.loading,
                child: btnTxt("Continue with Paystack"),
              ),
            ],
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: screenWidth(context),
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: WHITE,
              border: Border(
                top: BorderSide(width: 0.7, color: BORDER),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      isSubscribed ? cancelPlan() : customNavigateBack(context);
                    },
                    child: labelText(
                      isSubscribed ? "Cancel plan" : "Go Back",
                      fontSize: 14,
                      color: isSubscribed ? RED : null,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                xSpace(width: 20),
                Expanded(
                  flex: 3,
                  child: SubmitBtn(
                    onPressed: () {
                      context.read<NavController>().updatePageListStack(
                            SubscriptionScreen.routeName,
                          );
                    },
                    color: BORDER,
                    title: btnTxt('View other plans', PRIMARY),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  getFeatures() {
    if (isObjectEmpty(subUpgrade.features)) return Container();
    List<Widget> _ = [];
    for (var f in (subUpgrade.features!)) {
      _.add(ListTile(
        contentPadding: const EdgeInsets.all(0),
        visualDensity: VisualDensity.compact,
        leading: const Icon(
          Icons.check_circle,
          size: 30,
          color: PRIMARY,
        ),
        title: labelText(
          f,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ));
    }
    return _;
  }

  _paystackPayment() async {
    var ref =
        "${Platform.isIOS ? "Ios" : "Android"}_${DateTime.now().microsecondsSinceEpoch}";

    try {
      // Make the call to the API, get the auth token.
      CustomPaystackResModel? paystackRes = await authCtrl.getPaystackAuthUrl(
        context,
        CustomPaystackModel(
          reference: ref,
          callback_url: tGMWebsite,
          // SubscriptionPlanKeys.business
          planKey: getSubscriptPlanKey(),
          metadata: const PaystackMetadataModel(
            cancel_action: paystackCancelActionUrl,
          ),
        ),
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
        if (res && mounted) {
          _onSuccessfulPaystackPayment(ref);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      showError(message: "Something went wrong, Try again");
    }
  }

  _onSuccessfulPaystackPayment(ref) async {
    bool done = await authCtrl.verifyAndUpgradeSubscription(ref);
    if (done && mounted) {
      //
    } else {
      // Sorta send the ref to BE, so as to document and track this payment...
    }
  }

  getSubscriptPlanKey() {
    if (subUpgrade.type == KeyString.pro) {
      return subUpgrade.period == KeyString.month
          ? talentMonthlySub
          : talentYearlySub;
    } else {
      return subUpgrade.period == KeyString.month
          ? busMonthlySub
          : busYearlySub;
    }
  }

  void cancelPlan() async {
    // if (navCtrl.currentIndex == 0) {
    final result = await showAlertDialog(
      context,
      body: subtext(
          "This will cancel your subscription by the end of the current billing cycle.",
          fontSize: 13),
      title: "Cancel plan",
      cancelTitle: "No, Cancel",
      okTitle: "Yes, Delete",
      okColor: RED,
      cancelColor: GRAY,
    );
    if (DialogAction.yes == result && mounted) {
      isSubscribed = false;
      setState(() {});
    }
  }
}
