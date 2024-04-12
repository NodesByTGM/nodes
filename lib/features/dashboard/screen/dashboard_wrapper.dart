import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_screen.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});
  static const String routeName = "/dashboard_wrapper";

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: screenPadding,
      // decoration: const BoxDecoration(
      //   gradient: profileLinearGradient,
      // ),
      child: Consumer<AuthController>(builder: (context, authCtrl, _) {
        UserModel user = authCtrl.currentUser;
        return getDashboard(user.type ?? 0);
      }),
    );
  }

  Widget getDashboard(int type) {
    /**
     * The business dashboard, is supposedly, meant to be at the For Business side of the app
     * If the logged in account is business, then the home should be their talent's profile...
     * Not entirely clear on how this should be anyways...
     */

    switch (type) {
      case 0:
        return const IndividualDashboardScreen();
      case 1:
        return const TalentDashboardScreen();
      case 2:
        return const BusinessDashboardScreen();
      default:
        return const IndividualDashboardScreen();
    }
  }
}
