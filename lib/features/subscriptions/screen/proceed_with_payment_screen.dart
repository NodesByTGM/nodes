import 'dart:io';

import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
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
  bool seeMore = false;

  List<String> features = [
    "Premium Talent Pool Access",
    "Featured Job Listings",
    "Analytics and Performance Metrics",
    "Access to GridTools Discovery Pack (Free)",
    "Promotion and Marketing Opportunities ",
  ];

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    navCtrl = locator.get<NavController>();
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
          padding: const EdgeInsets.only(top: 32, bottom: 60),
          children: [
            labelText(
              "Proceed with payment",
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
                    "Pro",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  ySpace(height: 16),
                  subtext(
                    "One sentence supporting text",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  ySpace(height: 32),
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labelText(
                        formatCurrencyAmount(Constants.naira, 7600),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: PRIMARY,
                      ),
                      subtext(
                        "/month",
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
            OutlineBtn(
              onPressed: () => _paystackPayment(busMonthlySub),
              // to be controlled dynamically later...
              borderColor: BORDER,
              leftIcon: Image.asset(
                ImageUtils.paystackIcon,
                height: 24,
              ),
              loading: authCtrl.loading,
              child: btnTxt("Continue with Paystack"),
            ),
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
            child: GestureDetector(
              onTap: () {
                context.read<NavController>().popPageListStack();
              },
              child: labelText(
                "Go Back",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  getFeatures() {
    if (isObjectEmpty(features)) return Container();
    List<Widget> _ = [];
    for (var f in features) {
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

  _paystackPayment(String type) async {
    var ref =
        "${Platform.isIOS ? "Ios" : "Android"}_${DateTime.now().microsecondsSinceEpoch}";
    // var ref = "t5o5vnfu13";

    try {
      // Make the call to the API, get the auth token.
      CustomPaystackResModel? paystackRes = await authCtrl.getPaystackAuthUrl(
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
  }) async {}
}
