import 'package:nodes/utilities/constants/exported_packages.dart';

class AccountAnalytics extends StatefulWidget {
  const AccountAnalytics({super.key});

  @override
  State<AccountAnalytics> createState() => _AccountAnalyticsState();
}

class _AccountAnalyticsState extends State<AccountAnalytics> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ySpace(height: 40),
        Row(
          children: [
            Expanded(
              child: analyticsCard(
                title: "No. of Clicks",
                value: "20",
              ),
            ),
            xSpace(width: 24),
            Expanded(
              child: analyticsCard(
                title: "No. of Saves",
                value: "24",
              ),
            ),
          ],
        ),
        ySpace(height: 24),
        analyticsCard(
          title: "No. of Applicants",
          value: "20",
        ),
        ySpace(height: 40),
        customDivider(),
        SubmitBtn(
          onPressed: () {},
          title: btnTxt("Save changes", WHITE),
          loading: false,
        ),
        ySpace(height: 10),
      ],
    );
  }

  Container analyticsCard({
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        16,
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
            title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 20),
          labelText(
            value,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
