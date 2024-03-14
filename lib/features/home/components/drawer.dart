import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool profileStatus = true;
  bool settingsStatus = true;
  @override
  Widget build(BuildContext context) {
    return Consumer2<NavController, AuthController>(
      builder: (context, navCtrl, authCtrl, _) {
        return Container(
          width: screenWidth(context) - 80,
          decoration: const BoxDecoration(
            color: WHITE,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        ImageUtils.appIcon,
                        height: 32,
                      ),
                      xSpace(width: 10),
                      GestureDetector(
                        onTap: () {
                          navigateBack(context);
                        },
                        child: const Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                customDivider(padding: const EdgeInsets.all(0)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      profileStatus = !profileStatus;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        cachedNetworkImage(
                          imgUrl: "",
                          size: 30,
                          shape: BoxShape.circle,
                        ),
                        xSpace(width: 10),
                        Expanded(
                          child: labelText(
                            "Jane Doe",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          profileStatus
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                ExpandableSection(
                  expand: profileStatus,
                  child: Column(
                    children: [
                      _menuItem(
                        icon: ImageUtils.homeIcon,
                        title: KeyString.homeScreen,
                        route: DrawerRouteTitle.Home,
                        // or any of the Home children screen is the currentPageListStackItem
                        isActive:
                            getActiveDrawer(navCtrl, KeyString.homeScreen),
                        onTap: () {
                          // Check if the currentPageListStackItem, is amongst the children of HOMe,
                          // Asin, did we get to the screen via the home tab, if yes, then yeah... it'll make
                          // Home active.
                          // And once clicked, just wipe the array clean...
                          closeDrawer();
                          navCtrl.resetPageListStack();
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.profileIcon,
                        title: KeyString.profileScreen,
                        route: DrawerRouteTitle.Profile,
                        isActive:
                            getActiveDrawer(navCtrl, KeyString.profileScreen),
                        onTap: () {
                          closeDrawer();
                          // Get to know who's logged in, i.e individual, Talent or Business, and direct them properly...
                          navCtrl.updatePageListStack(
                            ProfileWrapper.routeName,
                          );
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.globeIcon,
                        title: KeyString.communityScreen,
                        route: DrawerRouteTitle.Community,
                        isActive:
                            getActiveDrawer(navCtrl, KeyString.communityScreen),
                        onTap: () {
                          closeDrawer();
                          navCtrl.updatePageListStack(
                            NodeSpacesScreen.routeName,
                          );
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.briefcaseIcon,
                        title: KeyString.forBusinessScreen,
                        route: DrawerRouteTitle.ForBusiness,
                        isActive: false,
                        onTap: () {
                          closeDrawer();
                          //
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.cubeIcon,
                        title: KeyString.subscriptionScreen,
                        route: DrawerRouteTitle.Subscription,
                        isActive: false,
                        onTap: () {
                          closeDrawer();
                          //
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.gridToolIcon,
                        title: KeyString.gridToolScreen,
                        route: DrawerRouteTitle.Subscription,
                        isActive: false,
                        onTap: () {
                          closeDrawer();
                          //
                        },
                      ),
                      ySpace(height: 32),
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: PRIMARY,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              xSpace(width: 8),
                              Image.asset(
                                ImageUtils.appIcon,
                                height: 20,
                                color: WHITE,
                              ),
                              xSpace(width: 10),
                              labelText(
                                KeyString.upgradeToProScreen,
                                color: WHITE,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      ySpace(height: 20),
                    ],
                  ),
                ),
                customDivider(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      settingsStatus = !settingsStatus;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        labelText(
                          "Settings and support",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        xSpace(width: 10),
                        Icon(
                          settingsStatus
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                ExpandableSection(
                  expand: settingsStatus,
                  child: Column(
                    children: [
                      _menuItem(
                        icon: ImageUtils.gridToolIcon,
                        title: "Logout",
                        route: DrawerRouteTitle.Profile,
                        isActive: false,
                        onTap: () {
                          closeDrawer();
                          // Get to know who's logged in, i.e individual, Talent or Business, and direct them properly...
                          navCtrl.resetPageListStack();
                          context.read<AuthController>().logout();
                          navigateAndClearAll(
                              context, WelcomeBackScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  closeDrawer() {
    navigateBack(context);
  }

  GestureDetector _menuItem({
    required String icon,
    required String title,
    required DrawerRouteTitle route,
    required GestureCancelCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
        ),
        decoration: BoxDecoration(
          color: isActive ? BORDER.withOpacity(0.4) : WHITE,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: BLACK.withOpacity(0.6),
            ),
            xSpace(width: 10),
            Expanded(
              child: subtext(
                title,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getActiveDrawer(NavController nCtrl, String route) {
    return nCtrl.persistentRoutes[route]
        .contains(nCtrl.currentPageListStackItem);
  }
}
