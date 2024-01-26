import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/home/views/welcome_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class NavbarView extends StatefulWidget {
  static const String routeName = '/navbar_view';

  // const NavbarView({Key? key}) : super(key: key);
  const NavbarView({Key? key}) : super(key: key);

  @override
  _NavbarViewState createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
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
    final _navCtrl = context.watch<NavController>();
    _authCtrl = context.watch<AuthController>();
    // String _userType = _authCtrl.currentUser.user_type ?? "";
    return WillPopScope(
      onWillPop: () async {
        if (_navCtrl.currentIndex == 0) {
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
        _navCtrl.currentIndexVal = 0;
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<AuthController>(
          builder: (context, model, _) {
            return labelText("label");
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          selectedItemColor: PRIMARY,
          unselectedItemColor: Colors.blueGrey.shade200,
          showUnselectedLabels: true,
          currentIndex: _navCtrl.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          unselectedLabelStyle: const TextStyle(
            height: 1.4,
          ),
          selectedLabelStyle: const TextStyle(
            height: 1.4,
          ),
          iconSize: 22,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          onTap: (index) {
          
          },
          items: _items(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _items() {
    
    return [
      const BottomNavigationBarItem(
        label: "",
        icon: Icon(
          Icons.home_outlined,
          size: 30,
        ),
      ),
      BottomNavigationBarItem(
        label: "",
        icon: Icon(
          MdiIcons.lineScan,
          size: 30,
        ),
      ),
      BottomNavigationBarItem(
        label: "",
        icon: Icon(
          MdiIcons.homeCityOutline,
          size: 30,
        ),
      ),
    ];
  }
}

void logout(BuildContext context) {
  context.read<AuthController>().logout();
  // context.read<NavController>().resetValues();
  // context.read<ProfileController>().resetController();
  // context.read<RequestController>().resetController();
  navigateAndClearAll(context, WelcomeScreen.routeName);
}
