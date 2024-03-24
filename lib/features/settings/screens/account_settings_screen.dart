import 'package:nodes/features/profile/components/interactions_tab.dart';
import 'package:nodes/features/profile/components/projects_tab.dart';
import 'package:nodes/features/settings/components/account_analytics.dart';
import 'package:nodes/features/settings/components/account_form.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  static const String routeName = "/account_settings_screen";

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ySpace(height: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText(
              "Account Settings",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            ySpace(height: 10),
            subtext(
              "We believe in the power of every individual's creative spark. ",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )
          ],
        ),
        ySpace(height: 40),
        StickyHeaderBuilder(
          builder: (context, stuckAmount) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              // color: stuckAmount <= -0.54 ? WHITE : null,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: BORDER),
                ),
                color: WHITE,
              ),
              child: Row(
                children: [
                  tabHeader(
                    isActive: currentIndex == 0,
                    title: "Account",
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),
                  xSpace(width: 10),
                  tabHeader(
                    isActive: currentIndex == 1,
                    title: "Analytics",
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            );
          },
          content: getTabBody(), 
        ),
      ],
    );
  }

  GestureDetector tabHeader({
    required bool isActive,
    required String title,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isActive ? PRIMARY : TRANSPARENT,
            ),
          ),
        ),
        child: labelText(
          title,
          fontSize: 16,
          color: isActive ? PRIMARY : BLACK,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  getTabBody() {
    return currentIndex == 0 ? AccountForm() : AccountAnalytics();
  }
}
