import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
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
  int planIndex = 0;
  double proAmt = 7900;
  double businessAmt = 19800;
  //
  double talentProPlanAmt = 7900;
  double talentOngoingProPlanAmt = 89800;
  double businessPlanAmt = 19800;
  double businessOngoingPlanAmt = 214800;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 32, bottom: 60),
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
          onTap: () => submit(isPro: true),
          btnText: "Upgrade Plan",
        ),
        ySpace(height: 16),
        SubscriptionCard(
          type: "Business",
          description: "One sentence  supporting text",
          price: formatCurrencyAmount(Constants.naira, businessAmt),
          planIndex: planIndex,
          isRecommended: false,
          features: Constants.businessFeatures,
          onTap: () => submit(isPro: false),
          btnText: "Upgrade Plan",
        ),
      ],
    );
  }

  updateAmt() {
    if (planIndex == 0) {
      setState(() {
        proAmt = 7900;
        businessAmt = 19800;
      });
    } else {
      setState(() {
        proAmt = 89800;
        businessAmt = 214800;
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

  submit({required bool isPro}) {
    // Save the upgrade type/data, either pro or business
    context.read<AuthController>().setSubUpgrade(
          SubscriptionUpgrade(
            type: isPro ? KeyString.pro : KeyString.bus,
            amount: isPro ? proAmt : businessAmt,
            period: planIndex == 0 ? KeyString.month : KeyString.year,
            features:
                isPro ? Constants.proFeatures : Constants.businessFeatures,
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
    required this.onTap,
    required this.btnText,
    required this.planIndex,
  });

  final String type;
  final String description;
  final String price;
  final bool isRecommended;
  final List<String> features;
  final GestureCancelCallback onTap;
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
            title: btnTxt(btnText, WHITE),
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
