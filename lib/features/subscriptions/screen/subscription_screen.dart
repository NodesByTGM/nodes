import 'package:nodes/core/controller/nav_controller.dart';
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
        SubscriptionCard(
          type: "Pro",
          description: "One sentence  supporting text",
          price: 7900,
          isRecommended: true,
          features: const [
            "Enhanced Visibility",
            "Access to Premium Jobs 1",
            "Expanded Project Showcase",
            "Access to GridTools Discovery Pack (Free)",
            "Advanced Analytics and Insights ",
          ],
          onTap: () => submit(isPro: true),
          btnText: "Upgrade Plan",
        ),
        ySpace(height: 16),
        SubscriptionCard(
          type: "Business",
          description: "One sentence  supporting text",
          price: 19800,
          isRecommended: false,
          features: const [
            "Premium Talent Pool Access",
            "Featured Job Listings",
            "Analytics and Performance Metrics",
            "Access to GridTools Discovery Pack (Free)",
            "Promotion and Marketing Opportunities ",
          ],
          onTap: () => submit(isPro: false),
          btnText: "Upgrade Plan",
        ),
      ],
    );
  }

  submit({required bool isPro}) {
    // Save the upgrade type/data, either pro or business
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
  });

  final String type;
  final String description;
  final double price;
  final bool isRecommended;
  final List<String> features;
  final GestureCancelCallback onTap;
  final String btnText;

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
                formatCurrencyAmount(Constants.naira, price),
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: PRIMARY,
              ),
              subtext(
                "/month",
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
