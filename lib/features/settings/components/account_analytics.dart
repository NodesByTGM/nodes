import 'package:nodes/utilities/constants/exported_packages.dart';

class AccountAnalytics extends StatefulWidget {
  const AccountAnalytics({
    super.key,
    this.isTalent = false,
    this.isBusiness = false,
  });

  final bool isTalent;
  final bool isBusiness;

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
        if (widget.isTalent) ...[
          Row(
            children: [
              Expanded(
                child: analyticsCard(
                  title: "No. of Profile visits",
                  value: "0",
                ),
              ),
              xSpace(width: 24),
              Expanded(
                child: analyticsCard(
                  title: "No. of Impressions",
                  value: "0",
                ),
              ),
            ],
          ),
        ],
        if (widget.isBusiness) ...[
          Row(
            children: [
              Expanded(
                child: analyticsCard(
                  title: "No. of Profile visits",
                  value: "0",
                ),
              ),
              xSpace(width: 24),
              Expanded(
                child: analyticsCard(
                  title: "No. of Impressions",
                  value: "0",
                ),
              ),
            ],
          ),
          ySpace(height: 24),
          analyticsCard(
            title: "No. of Unique Visitors",
            value: "0",
          ),
        ],
        ySpace(height: 50),
      ],
    );
  }
}
