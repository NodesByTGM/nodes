import 'package:nodes/features/community/models/currently_viewed_user_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/profile/screens/profiles_seen_as_guest/business_guest_profile.dart';
import 'package:nodes/features/profile/screens/profiles_seen_as_guest/individual_guest_profile.dart';
import 'package:nodes/features/profile/screens/profiles_seen_as_guest/talent_guest_profile.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ProfileGuestWrapper extends StatelessWidget {
  const ProfileGuestWrapper({super.key});
  static const String routeName = "/profile_guest_wrapper";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PROFILEBG,
      ),
      child: Column(
        children: [
          Expanded(
            child: getUserProfile(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth(context),
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              decoration: const BoxDecoration(
                color: WHITE,
                border: Border(
                  top: BorderSide(width: 0.7, color: BORDER),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  customNavigateBack(context);
                },
                child: labelText(
                  "Go Back",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getUserProfile(BuildContext context) {
    CurrentlyViewedUser user =
        context.read<ComController>().currentlyViewedUser;
    switch (user.type) {
      case 0:
        return IndividualGuestProfileScreen(
          id: "${user.id}",
        );
      case 1:
        return TalentGuestProfileScreen(
          id: "${user.id}",
        );
      case 2:
        return BusinessGuestProfileScreen(
          id: "${user.id}",
        );
      default:
        return IndividualGuestProfileScreen(
          id: "${user.id}",
        );
    }
  }
}
