import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/subscriptions/screen/proceed_with_payment_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/tag_chip.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  static const String routeName = "/subscription_screen";

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late AuthController authCtrl;
  late UserModel user;
  int planIndex = 0;
  double proAmt = 7900;
  double businessAmt = 19800;
  //
  double talentProPlanAmt = 7900;
  double talentOngoingProPlanAmt = 89800;
  double businessPlanAmt = 19800;
  double businessOngoingPlanAmt = 214800;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 32, bottom: 120),
          children: [
            labelText(
              "Choose a plan",
              height: 2,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            subtext(
              "Simple pricing for your needs.",
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            ySpace(height: 32),
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
            ySpace(height: 32),
            SubscriptionCard(
                type: "Pro",
                description: "One sentence  supporting text",
                price: formatCurrencyAmount(Constants.naira, proAmt),
                planIndex: planIndex,
                isRecommended: true,
                features: Constants.proFeatures,
                isSubscribed: isSubscribed(isPro: true),
                // onTap: isSubscribed(isPro: true) ? () => submit(isPro: true) : null,
                onTap: () => submit(isPro: true),
                btnText: btnText(isPro: true)),
            ySpace(height: 16),
            SubscriptionCard(
              type: "Business",
              description: "One sentence  supporting text",
              price: formatCurrencyAmount(Constants.naira, businessAmt),
              planIndex: planIndex,
              isRecommended: false,
              features: Constants.businessFeatures,
              isSubscribed: isSubscribed(isPro: false),
              // onTap: isSubscribed(isPro: false) ? () => submit(isPro: false) : null,
              onTap: () => submit(isPro: false),
              btnText: btnText(isPro: false),
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
                customNavigateBack(context);
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
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  String btnText({required bool isPro}) =>
      isSubscribed(isPro: isPro) ? "Current Plan" : "Upgrade Plan";

  bool isSubscribed({required bool isPro}) {
    // Check if the user's current subscription is
    // Pro or business i.e monthly sub
    // Pro-annual or business-annual i.e yearly sub
    String? currentUserSub = user.subscription?.plan;
    bool isMonthPlan = planIndex == 0;
    bool isYearPlan = planIndex == 1;
    if (isObjectEmpty(currentUserSub)) {
      return true; // meaning user hasn't subscribed yet, hence the button should be active...
    }
    if (isPro) {
      // If currentUserSub is Pro or Pro-annual, and we're in month's or year tab, then disable button.
      if (isMonthPlan) {
        return currentUserSub?.toLowerCase() == talentMonthlySub.toLowerCase()
            ? true
            : false;
      } else if (isYearPlan) {
        return currentUserSub?.toLowerCase() == talentYearlySub.toLowerCase()
            ? true
            : false;
      }
      return false;
    } else {
      // If currentUserSub is Business or Business-annual, and we're in month's or year tab, then disable button.
      if (isMonthPlan) {
        return currentUserSub?.toLowerCase() == busMonthlySub.toLowerCase()
            ? true
            : false;
      } else if (isYearPlan) {
        return currentUserSub?.toLowerCase() == busYearlySub.toLowerCase()
            ? true
            : false;
      }
      return false;
    }
  }

  submit({required bool isPro}) {
    // Save the upgrade type/data, either pro or business
    authCtrl.setSubUpgrade(
      SubscriptionUpgrade(
        type: isPro ? KeyString.pro : KeyString.bus,
        amount: isPro ? proAmt : businessAmt,
        period: planIndex == 0 ? KeyString.month : KeyString.year,
        features: isPro ? Constants.proFeatures : Constants.businessFeatures,
        isSubscribed: isSubscribed(isPro: isPro),
      ),
    );
    context.read<NavController>().updatePageListStack(
          ProceedWithPayment.routeName,
        );
  }
}

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.type,
    required this.description,
    required this.price,
    required this.isRecommended,
    required this.features,
    required this.isSubscribed,
    this.onTap,
    required this.btnText,
    required this.planIndex,
  });

  final String type;
  final String description;
  final String price;
  final bool isRecommended;
  final List<String> features;
  final bool isSubscribed;
  final GestureCancelCallback? onTap;
  final String btnText;
  final int planIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              labelText(
                type,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              if (isRecommended) ...[
                xSpace(width: 16),
                const CustomTagChip(
                  title: "Recommended plan ",
                  borderRadius: 20,
                  color: GRAY,
                ),
              ],
            ],
          ),
          ySpace(height: 16),
          subtext(
            description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 32),
          Wrap(
            spacing: 2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              labelText(
                price,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: PRIMARY,
              ),
              subtext(
                "/${planIndex == 0 ? 'month' : 'year'}",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          customDivider(height: 40),
          labelText(
            "Features:",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 24),
          ...getFeatures(),
          ySpace(height: 24),
          SubmitBtn(
            onPressed: onTap,
            title: btnTxt(btnText, isSubscribed ? PRIMARY : WHITE),
            color: isSubscribed ? BORDER : PRIMARY,
          ),
        ],
      ),
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
}
