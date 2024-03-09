import 'package:nodes/core/controller/nav_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            top: 40,
          ),
          child: ProfileCard(
            child: Column(
              children: [
                cachedNetworkImage(
                  imgUrl:
                      "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                  size: 100,
                ),
                ySpace(height: 24),
                labelText(
                  "Jane Doe",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 8),
                labelText(
                  "@JD",
                  fontSize: 14,
                  color: GRAY,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 24),
                // subtext(
                //   "Height 68cm | Age 23 years",
                //   color: GRAY,
                // ),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    subtext(
                      "Height",
                      color: GRAY,
                    ),
                    subtext(
                      "68cm",
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
                      "23 years",
                    ),
                  ],
                ),
                ySpace(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageUtils.mapLocationIcon,
                            color: GRAY,
                          ),
                          xSpace(width: 5),
                          subtext(
                            "Add Location",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GRAY,
                          ),
                        ],
                      ),
                      xSpace(width: 10),
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageUtils.chainLinkIcon,
                            color: GRAY,
                          ),
                          xSpace(width: 5),
                          subtext(
                            "Add Websites",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GRAY,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ySpace(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                ),
                ySpace(height: 40),
                CustomDottedBorder(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(
                        "Your headline and bio goes here",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      ySpace(height: 10),
                      // Find a way to work with the overflowww...
                      subtext(
                        // "Share more about yourself and what you hope to accomplish",
                        "Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. ",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                if (isRegistered) ...[
                  ySpace(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: OutlineBtn(
                          onPressed: () {},
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
              ],
            ),
          ),
        ),
        ySpace(),
        StickyHeaderBuilder(
          builder: (context, stuckAmount) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(top: 10),
              color: stuckAmount <= -0.54 ? WHITE : null,
              child: Row(
                children: [
                  tabHeader(
                      isActive: currentIndex == 0,
                      title: "Projects",
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      }),
                  xSpace(width: 50),
                  tabHeader(
                      isActive: currentIndex == 1,
                      title: "Interactions",
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      }),
                ],
              ),
            );
          },
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ProfileCard(
              child: getTabBody(),
            ),
          ),
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
        padding: const EdgeInsets.only(bottom: 10),
        margin: const EdgeInsets.only(bottom: 10),
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
    return currentIndex == 0 ? ProjectsTab() : InteractionsTab();
  }
}
