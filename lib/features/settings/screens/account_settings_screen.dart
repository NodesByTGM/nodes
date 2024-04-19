import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
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
  // Get who is logged in.
  late AuthController authCtrl;
  late bool isBusiness;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    isBusiness = authCtrl.currentUser.type == 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
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
              child: SingleChildScrollView(
                scrollDirection: isBusiness ? Axis.horizontal : Axis.vertical,
                child: Row(
                  mainAxisAlignment: isBusiness
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
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
                    if (!isBusiness) ...[
                      xSpace(width: 10),
                    ],
                    if (authCtrl.currentUser.type != 0) ...[
                      // Means can show the below data provided the logged in user ain't standard
                      tabHeader(
                        isActive: currentIndex == 1,
                        title: isBusiness ? "Personal Analytics" : "Analytics",
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                      ),
                      if (isBusiness) ...[
                        tabHeader(
                          isActive: currentIndex == 2,
                          title: "Business Analytics",
                          onTap: () {
                            setState(() {
                              currentIndex = 2;
                            });
                          },
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            );
          },
          content: getTabBody(),
        ),
      ],
    );
  }

  getTabBody() {
    switch (currentIndex) {
      case 0:
        return const AccountForm();
      case 1:
        return const AccountAnalytics(
          isTalent: true,
        );
      case 2:
        return AccountAnalytics(
          isBusiness: isBusiness,
        );
      default:
        return const AccountForm();
    }
  }
}
