import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/profile/screens/business/business_profile_screen.dart';
import 'package:nodes/features/profile/screens/individual/individual_profile_screen.dart';
import 'package:nodes/features/profile/screens/talent/talent_profile_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({super.key});
  static const String routeName = "/profile_wrapper";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PROFILEBG,
      ),
      child: getUserProfile(context),
    );
  }

  Widget getUserProfile(BuildContext context) {
    UserModel user = context.read<AuthController>().currentUser;
    switch (user.type) {
      case 0:
        return const IndividualProfileScreen();
      case 1:
        return const TalentProfileScreen();
      case 2:
        return const BusinessProfileScreen();
      default:
        return const IndividualProfileScreen();
    }
  }
}
