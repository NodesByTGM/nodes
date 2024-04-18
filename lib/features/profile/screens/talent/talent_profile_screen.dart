import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/components/interactions_tab.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/profile/components/projects_tab.dart';
import 'package:nodes/features/profile/screens/talent/edit_talent_profile_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class TalentProfileScreen extends StatefulWidget {
  const TalentProfileScreen({super.key});
  static const String routeName = "/talent_profile_screen";

  @override
  State<TalentProfileScreen> createState() => _TalentProfileScreenState();
}

class _TalentProfileScreenState extends State<TalentProfileScreen> {
  int currentIndex = 0;
  bool isRegistered = true;
  late UserModel user;
  late AuthController authCtrl;
  late DashboardController dashCtrl;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    user = authCtrl.currentUser;
    safeNavigate(
        () => context.read<DashboardController>().fetchMyProjects(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    dashCtrl = context.watch<DashboardController>();
    return ListView(
      children: [
        Container(
          color: WHITE,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ySpace(height: 24),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: cachedNetworkImage(
                  imgUrl: "${user.avatar?.url}",
                  size: 100,
                ),
                title: labelText(
                  "${user.name}",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ySpace(height: 2),
                    labelText(
                      "@${user.username}",
                      fontSize: 14,
                      color: GRAY,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 5),
                    Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        subtext(
                          "Height",
                          color: GRAY,
                        ),
                        subtext(
                          "${!isObjectEmpty(user.height) ? user.height : '**'}cm",
                        ),
                        subtext(
                          "|",
                          color: GRAY,
                        ),
                        subtext(
                          "Age",
                          color: GRAY,
                        ),
                        subtext(
                          "${!isObjectEmpty(user.age) ? user.age : '**'} years",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ySpace(height: 24),
              CustomDottedBorder(
                child: SizedBox(
                  width: screenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(
                        !isObjectEmpty(user.headline)
                            ? "${user.headline}"
                            : "Your headline and bio goes here",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      ySpace(height: 10),
                      subtext(
                        !isObjectEmpty(user.bio)
                            ? "${user.bio}"
                            : "Share more about yourself and what you hope to accomplish",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
              ySpace(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageUtils.mapLocationIcon,
                          color: GRAY,
                        ),
                        xSpace(width: 5),
                        subtext(
                          !isObjectEmpty(user.location)
                              ? "${user.location}"
                              : "Location",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: GRAY,
                        ),
                      ],
                    ),
                  ),
                  xSpace(width: 10),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 15,
                    children: userSocials(user),
                  ),
                ],
              ),
              ySpace(height: 24),
              Row(
                children: [
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labelText(
                        "26",
                        fontSize: 12,
                      ),
                      subtext(
                        "Followers",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  xSpace(width: 10),
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labelText(
                        "26",
                        fontSize: 12,
                      ),
                      subtext(
                        "Following",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              ySpace(height: 24),
              if (isRegistered) ...[
                ySpace(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlineBtn(
                        onPressed: () async {
                          if (isTalentProfileComplete(user)) {
                            await shareDoc(
                              context,
                              url: "$nodeWebsite/${user.username}",
                            );
                          } else {
                            showText(
                              message: "Please update your profile to proceed.",
                            );
                          }
                        },
                        borderColor: PRIMARY,
                        color: WHITE,
                        height: 48,
                        child: btnTxt(
                          "Share Profile",
                          PRIMARY,
                        ),
                      ),
                    ),
                    xSpace(width: 10),
                    Expanded(
                      child: SubmitBtn(
                        height: 48,
                        onPressed: () {
                          context.read<NavController>().updatePageListStack(
                              EditTalentProfileScreen.routeName);
                        },
                        title: btnTxt(
                          "Edit Your Profile",
                          WHITE,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              ySpace(height: 32),
            ],
          ),
        ),
        StickyHeaderBuilder(
          builder: (context, stuckAmount) {
            return Container(
              padding: const EdgeInsets.only(top: 5),
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
                    title: "Projects",
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),
                  xSpace(width: 10),
                  tabHeader(
                    isActive: currentIndex == 1,
                    title: "Interactions",
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
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Consumer<DashboardController>(
              builder: (c, dCtrl, _) {
                return getTabBody(dCtrl);
              },
            ),
          ),
        ),
      ],
    );
  }

  getTabBody(DashboardController dc) {
    return currentIndex == 0
        ? ProjectsTab(
            projects: dc.myProjectList,
          )
        : InteractionsTab();
  }
}
