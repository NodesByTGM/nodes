import 'package:nodes/config/dynamic_page_routes.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/features/home/components/drawer.dart';
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

  initSession() async {
    _authCtrl = context.read<AuthController>();
    // CurrentSession? session = await _authCtrl.currentSession;
    CurrentSession? session = await _authCtrl.currentSession;
    if (!isObjectEmpty(session?.access)) {
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
    return WillPopScope(
      onWillPop: () async {
        // navCtrl.popPageListStack();
        // if (navCtrl.pageListStack.length == 1) {
        if (navCtrl.currentIndex == 0) {
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
        navCtrl.currentIndexVal = 0;
        return false;
      },
      child: AppWrapper(
        scafoldKey: _scaffoldKey,
        isCancel: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => _openDrawer(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(
              ImageUtils.menuIcon,
            ),
          ),
        ),
        title: Image.asset(
          ImageUtils.appIcon,
          height: 32,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              ImageUtils.bellIcon,
              height: 32,
            ),
          ),
          xSpace(width: 24),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              ImageUtils.envelopeIcon,
              height: 32,
            ),
          ),
          xSpace(width: 20),
        ],
        body: Consumer<NavController>(
          builder: (context, model, _) {
            // Get screen from stack
            return getDynamicScreen(model);
          },
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }

  _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

}

void logout(BuildContext context) {
  context.read<AuthController>().logout();
  // context.read<NavController>().resetValues();
  // context.read<ProfileController>().resetController();
  context.read<AuthController>().setCurrentScreen(WelcomeBackScreen.routeName);
  navigateAndClearAll(context, WelcomeBackScreen.routeName);
}
