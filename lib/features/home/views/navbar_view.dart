// ignore_for_file: use_build_context_synchronously

import 'package:nodes/config/dynamic_page_routes.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_event_details_screen.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_job_details_screen.dart';
import 'package:nodes/features/dashboard/screen/dashboard_wrapper.dart';
import 'package:nodes/features/home/components/drawer.dart';
import 'package:nodes/features/messages/screen/message_screen.dart';
import 'package:nodes/features/notification/screen/notification_screen.dart';
import 'package:nodes/features/profile/screens/business/business_profile_screen.dart';
import 'package:nodes/features/profile/screens/business/edit_business_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/edit_individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/profile_guest_wrapper.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/features/profile/screens/talent/edit_talent_profile_screen.dart';
import 'package:nodes/features/profile/screens/talent/talent_profile_screen.dart';
import 'package:nodes/features/saves/screens/saved_items_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class NavbarView extends StatefulWidget {
  static const String routeName = '/navbar_view';

  const NavbarView({Key? key}) : super(key: key);

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late AuthController _authCtrl;
  late CurrentSession? session;
  bool isRegistered = true;

  initSession() async {
    _authCtrl = context.read<AuthController>();
    // CurrentSession? session = await _authCtrl.currentSession;
    CurrentSession? session = await _authCtrl.currentSession;
    if (!isObjectEmpty(session?.accessToken)) {
      _authCtrl.currentUserVal = session!;
    } else {
      debugPrint("This user does not have an accessToken");
    }
  }

  @override
  void initState() {
    initSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navCtrl = context.watch<NavController>();
    _authCtrl = context.watch<AuthController>();
    // String _userType = _authCtrl.currentUser.user_type ?? "";
    EdgeInsets? genScreenpadding = shouldHavePadding(navCtrl);
    return WillPopScope(
      onWillPop: () async {
        // navCtrl.popPageListStack();
        // Check if the dashboard is the only data in the pageList, if yes, continue with prompt.
        // Else, call the reset list, or pop last item...
        if (navCtrl.currentIndex == 0 &&
            navCtrl.currentPageListStackItem == DashboardWrapper.routeName) {
          // if (navCtrl.currentIndex == 0) {
          final result = await showAlertDialog(
            context,
            body: subtext("Are you sure you want to logout?", fontSize: 13),
            title: "Confirmation",
          );
          if (DialogAction.yes == result) {
            safeNavigate(() => logout(context));
            return true;
          }
          return false;
        }
        navCtrl.popPageListStack(); // Remove the last added page...
        navCtrl.currentIndexVal = 0;
        return false;
      },
      child: AppWrapper(
        scafoldKey: _scaffoldKey,
        isCancel: false,
        safeBottom: false, // used to remove the safeArea bottom
        backgroundColor: Colors.white,
        // padding: const EdgeInsets.all(0),
        // There might be some screens where I won't want the padding to reflect, so I add them in an array...
        padding: genScreenpadding,
        leading: isRegistered
            ? GestureDetector(
                onTap: () => _openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SvgPicture.asset(
                    ImageUtils.menuIcon,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Image.asset(
                  ImageUtils.appIcon,
                  height: 25,
                ),
              ),
        title: isRegistered
            ? Image.asset(
                ImageUtils.appIcon,
                height: 32,
              )
            : null,
        centerTitle: isRegistered,
        actions: isRegistered
            ? [
                GestureDetector(
                  onTap: () {
                    navigateTo(context, NotificationScreen.routeName);
                  },
                  child: SvgPicture.asset(
                    ImageUtils.bellIcon,
                    height: 32,
                  ),
                ),
                xSpace(width: 24),
                GestureDetector(
                  onTap: () {
                    navigateTo(context, MessageScreen.routeName);
                  },
                  child: SvgPicture.asset(
                    ImageUtils.envelopeIcon,
                    height: 32,
                  ),
                ),
                xSpace(width: 20),
              ]
            : [
                SizedBox(
                  width: 100,
                  height: 47,
                  child: OutlineBtn(
                    onPressed: () {},
                    borderColor: WHITE,
                    color: WHITE,
                    child: btnTxt("Login", BLACK),
                  ),
                ),
                xSpace(width: 10),
                SizedBox(
                  width: 100,
                  height: 47,
                  child: SubmitBtn(
                    onPressed: () {},
                    title: btnTxt("Sign Up", WHITE),
                  ),
                ),
                xSpace(width: 16),
              ],
        body: Consumer<NavController>(
          builder: (context, model, _) {
            // Get screen from stack
            return getDynamicScreen(model);
          },
        ),
        drawer: isRegistered ? const DrawerWidget() : null,
      ),
    );
  }

  _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

// This is used to denote which screens should have the default padding an all...
  EdgeInsets? shouldHavePadding(NavController ctrl) {
    return [
      NodeSpacesScreen.routeName,
      NodeCommunityScreen.routeName,
      ProfileWrapper.routeName,
      ProfileGuestWrapper.routeName,
      IndividualProfileScreen.routeName,
      EditIndividualProfileScreen.routeName,
      TalentProfileScreen.routeName,
      EditTalentProfileScreen.routeName,
      BusinessProfileScreen.routeName,
      EditBusinessProfileScreen.routeName,
      //
      // DashboardWrapper.routeName,
      // TalentAppliedJobCenterScreen.routeName,
      BusinessJobDetailsScreen.routeName,
      BusinessEventDetailsScreen.routeName,
      SavedItemScreen.routeName,
      // SubscriptionScreen.routeName,
    ].contains(ctrl.currentPageListStackItem)
        ? const EdgeInsets.all(0)
        : null;
  }
}

void logout(BuildContext context) async {
  // bool done = await context.read<AuthController>().serverLogout(context);
  // if (done) {
  // }
  context.read<AuthController>().logout();
  navigateTo(context, WelcomeBackScreen.routeName);
}
