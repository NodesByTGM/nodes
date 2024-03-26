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
      padding: const EdgeInsets.only(top: 40),
      children: [
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
}
