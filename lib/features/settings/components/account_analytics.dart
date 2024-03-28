import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

class AccountAnalytics extends StatefulWidget {
  const AccountAnalytics({
    super.key,
    required this.accountType,
    this.isIndividual = false,
    this.isTalent = false,
    this.isBusiness = false,
  });

  final LoggedInAccountType accountType;
  final bool isIndividual;
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
        if (widget.accountType == LoggedInAccountType.Individual) ...[
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
        ],
        // if (widget.accountType == LoggedInAccountType.Talent) ...[
        if (widget.accountType == LoggedInAccountType.Talent ||
            widget.accountType == LoggedInAccountType.BusinessTalent) ...[
          Row(
            children: [
              Expanded(
                child: analyticsCard(
                  title: "No. of Profile visits",
                  value: "20",
                ),
              ),
              xSpace(width: 24),
              Expanded(
                child: analyticsCard(
                  title: "No. of Impressions",
                  value: "24",
                ),
              ),
            ],
          ),
        ],
        if (widget.accountType == LoggedInAccountType.Business) ...[
          Row(
            children: [
              Expanded(
                child: analyticsCard(
                  title: "No. of Profile visits",
                  value: "20",
                ),
              ),
              xSpace(width: 24),
              Expanded(
                child: analyticsCard(
                  title: "No. of Impressions",
                  value: "24",
                ),
              ),
            ],
          ),
          ySpace(height: 24),
          analyticsCard(
            title: "No. of Unique Visitors",
            value: "20",
          ),
        ],
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
