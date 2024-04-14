import 'package:expandable_section/expandable_section.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_pre_dashboard_screen.dart';
import 'package:nodes/features/grid_tools/screens/grid_tools_screen.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/features/saves/screens/saved_items_screen.dart';
import 'package:nodes/features/settings/screens/account_settings_screen.dart';
import 'package:nodes/features/subscriptions/screen/proceed_with_payment_screen.dart';
import 'package:nodes/features/subscriptions/screen/subscription_screen.dart';
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
        UserModel user = authCtrl.currentUser;
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
                          imgUrl: "${user.avatar}",
                          size: 30,
                          borderRadius: 100,
                        ),
                        xSpace(width: 10),
                        Expanded(
                          child: labelText(
                            "${user.name}",
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
                        // title: KeyString.homeScreen,
                        title: "Dashboard",
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
                            // NodeSpacesScreen.routeName,
                            // Starting with Community as an MVP
                            NodeCommunityScreen.routeName,
                          );
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.briefcaseIcon,
                        title: KeyString.forBusinessScreen,
                        route: DrawerRouteTitle.ForBusiness,
                        isActive: getActiveDrawer(
                            navCtrl, KeyString.forBusinessScreen),
                        onTap: () {
                          closeDrawer();
                          user.type == 2
                              ? navCtrl.updatePageListStack(
                                  BusinessDashboardScreen.routeName,
                                )
                              : navCtrl.updatePageListStack(
                                  BusinessPreDashbaordScreen.routeName,
                                );
                        },
                      ),
                      _menuItem(
                        icon: ImageUtils.cubeIcon,
                        title: KeyString.subscriptionScreen,
                        route: DrawerRouteTitle.Subscription,
                        isActive: getActiveDrawer(
                            navCtrl, KeyString.subscriptionScreen),
                        onTap: () {
                          closeDrawer();
                          navCtrl.updatePageListStack(
                            SubscriptionScreen.routeName,
                          );
                        },
                      ),
                      if (user.type != 0) ...[
                        // Where 0 is Default user
                        _menuItem(
                          icon: ImageUtils.starOutlineIcon,
                          title: KeyString.trendingScreen,
                          route: DrawerRouteTitle
                              .Trending, // Send to individual dashboard... or reproduce it...
                          // isActive: getActiveDrawer(
                          //     navCtrl, KeyString.trendingScreen),
                          isActive: false,
                          onTap: () {
                            closeDrawer();
                            navCtrl.resetPageListStack();
                            // navCtrl.updatePageListStack(
                            //   UpgradeToProScreen.routeName,
                            // );
                          },
                        ),
                      ],
                      _menuItem(
                        icon: ImageUtils.gridToolIcon,
                        title: KeyString.gridToolScreen,
                        route: DrawerRouteTitle.Subscription,
                        isActive:
                            getActiveDrawer(navCtrl, KeyString.gridToolScreen),
                        onTap: () {
                          closeDrawer();
                          navCtrl.updatePageListStack(
                            GridToolsScreen.routeName,
                          );
                        },
                      ),
                      if (user.type == 0) ...[
                        _menuItem(
                          icon: ImageUtils.upgradeToProIcon,
                          title: KeyString.upgradeToProScreen,
                          route: DrawerRouteTitle.UpgradeToPro,
                          isActive: getActiveDrawer(
                              navCtrl, KeyString.upgradeToProScreen),
                          onTap: () {
                            closeDrawer();
                            bool isSubscribedToProMonth =
                                user.subscription?.plan?.toLowerCase() ==
                                    talentMonthlySub;
                            context.read<AuthController>().setSubUpgrade(
                                  SubscriptionUpgrade(
                                    type: KeyString.pro,
                                    amount: proMonthlyAmt,
                                    period: KeyString.month,
                                    features: Constants.proFeatures,
                                    isSubscribed: isSubscribedToProMonth,
                                  ),
                                );
                            navCtrl.updatePageListStack(
                              ProceedWithPayment.routeName,
                              // get the pro/talent data passed to it.. or just look for another way of passing data bro
                            );
                          },
                        ),
                      ],
                      ySpace(height: 10),
                    ],
                  ),
                ),
                customDivider(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                if (user.type == 1) ...[
                  _menuItem(
                    icon: ImageUtils.saveJobIcon,
                    title: KeyString.savesScreen,
                    route: DrawerRouteTitle.SavedJobs,
                    isActive: getActiveDrawer(navCtrl, KeyString.savesScreen),
                    onTap: () {
                      closeDrawer();
                      navCtrl.updatePageListStack(
                        SavedItemScreen.routeName,
                      );
                    },
                  ),
                ],
                _menuItem(
                  icon: ImageUtils.settingsIcon,
                  title: KeyString.accountSettingsScreen,
                  route: DrawerRouteTitle.AccountSettings,
                  isActive: false,
                  onTap: () {
                    closeDrawer();
                    navCtrl.updatePageListStack(
                      AccountSettingsScreen.routeName,
                    );
                  },
                ),
                _menuItem(
                    icon: ImageUtils.logoutIcon,
                    title: "Logout",
                    route: DrawerRouteTitle.Profile,
                    isActive: false,
                    onTap: () {
                      safeNavigate(() => logout(context));
                      navCtrl.resetPageListStack();
                      context.read<AuthController>().logout();
                      navigateAndClearAll(context, WelcomeBackScreen.routeName);
                    }
                    // onTap: () async {
                    //   closeDrawer();
                    //   final result = await showAlertDialog(
                    //     context,
                    //     body: subtext("Are you sure you want to logout?",
                    //         fontSize: 13),
                    //     title: "Confirmation",
                    // okColor: RED,
                    // cancelColor: GRAY,
                    //   );
                    //   if (DialogAction.yes == result) {
                    //     if (mounted) {
                    //       safeNavigate(() => logout(context));
                    //       navCtrl.resetPageListStack();
                    //       context.read<AuthController>().logout();
                    //       navigateAndClearAll(
                    //           context, WelcomeBackScreen.routeName);
                    //     }
                    //   } else {
                    //     print("I said cancel George");
                    //     if (mounted) {
                    //       navigateBack(context);
                    //     }
                    //   }
                    // },
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
              height: 20,
            ),
            xSpace(width: 10),
            Expanded(
              child: subtext(
                title,
                fontSize: 14,
                color: BLACK,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // GestureDetector _menuItem({
  //   required String icon,
  //   required String title,
  //   required DrawerRouteTitle route,
  //   required GestureCancelCallback onTap,
  //   bool isActive = false,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.symmetric(
  //             // vertical: 10,
  //             horizontal: 12,
  //           ),
  //           margin: const EdgeInsets.only(
  //             // bottom: 12,
  //             left: 12,
  //             right: 12,
  //           ),
  //           decoration: BoxDecoration(
  //             color: isActive ? BORDER.withOpacity(0.4) : WHITE,
  //             borderRadius: BorderRadius.circular(4),
  //           ),
  //           child: Row(
  //             children: [
  //               SvgPicture.asset(
  //                 icon,
  //                 color: BLACK.withOpacity(0.6),
  //                 height: 20,
  //               ),
  //               xSpace(width: 10),
  //               Expanded(
  //                 child: subtext(
  //                   title,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         ExpandableSection(
  //           expand: true,
  //           child: Column(
  //             children: [
  //               ListTile(
  //                 contentPadding: const EdgeInsets.only(left: 50),
  //                 title: labelText("Dashboard"),
  //                 onTap: () {},
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  getActiveDrawer(NavController nCtrl, String route) {
    return nCtrl.persistentRoutes[route]
        .contains(nCtrl.currentPageListStackItem);
  }
}
