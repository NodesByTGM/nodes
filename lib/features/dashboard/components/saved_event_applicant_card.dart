import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/models/currently_viewed_user_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/profile/screens/profile_guest_wrapper.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class SavedEventApplicantCard extends StatelessWidget {
  const SavedEventApplicantCard({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return isObjectEmpty(event.saves)
        ? SizedBox(
            height: 200,
            child: Center(
              child: labelText("Nobody has saved this event yet"),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: event.saves?.length ?? 0,
            padding: const EdgeInsets.only(top: 32),
            itemBuilder: (c, i) {
              ApplicantModel saver = event.saves![i];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: WHITE,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 0.7,
                    color: BORDER,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cachedNetworkImage(
                      imgUrl: "${saver.avatar?.url}",
                      size: 40,
                    ),
                    ySpace(height: 10),
                    labelText(
                      capitalize("${saver.name}"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 10),
                    subtext(
                      "${saver.email}",
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          // First add the ID to the currentlyViewedProfile
                          context.read<ComController>().setCurrentlyViewedUser(
                                CurrentlyViewedUser(
                                  id: "${saver.id}",
                                  // because only talents can apply for jobs...
                                  type: saver.type,
                                ),
                              );
                          context.read<NavController>().updatePageListStack(
                                ProfileGuestWrapper.routeName,
                              );
                        },
                        // send them to either individual or talent profile, but restrict the edit profile access...
                        // Simply ask backend to include the account type, so you'd know where to send this business owner to.
                        child: labelText(
                          "View profile",
                          color: PRIMARY,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 16),
          );
  }
}
