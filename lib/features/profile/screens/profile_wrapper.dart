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
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        gradient: profileLinearGradient,
      ),
      child: getUserProfile(),
    );
  }
  // Widget build(BuildContext context) {
  //   return getUserProfile();
  // }

  Widget getUserProfile() {
    switch (2) {
      case 1:
        return const IndividualProfileScreen();
      case 2:
        return const TalentProfileScreen();
      case 3:
        return const BusinessProfileScreen();
      default:
        return const IndividualProfileScreen();
    }
  }
}
