import 'package:nodes/features/community/models/general_user_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/messages/screen/single_message_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class PeopleBrandCard extends StatelessWidget {
  const PeopleBrandCard({
    super.key,
    this.isConnected = false,
    required this.genUser,
  });

  final bool isConnected;
  final GeneralUserModel genUser;

  @override
  Widget build(BuildContext context) {
    List<String> usersType = ["Standard", "Pro", "Business"];

    bool hasHeadlineOrBio =
        !isObjectEmpty(genUser.headline) || !isObjectEmpty(genUser.bio);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 0.8, color: BORDER),
        borderRadius: BorderRadius.circular(8),
        color: WHITE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cachedNetworkImage(
                imgUrl: "${genUser.avatar?.url}",
                size: 45,
              ),
              xSpace(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      capitalize("${genUser.name}"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    subtext(
                      "${usersType[genUser.type]} User",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GRAY,
                    ),
                  ],
                ),
              ),
              xSpace(width: 10),
              context.watch<ComController>().isRequestingConnection
                  ? const Loader()
                  : GestureDetector(
                      onTap: () {
                        if (isConnected) {
                          // probably fetch the user something before sending them here...
                          navigateTo(context, SingleMessageDetails.routeName);
                        } else {
                          // Function to Connect with user/brand
                          context.read<ComController>().requestConnection(
                                context,
                                "${genUser.id}",
                              );
                        }
                      },
                      child: labelText(
                        isConnected ? "Message" : "Connect",
                        color: PRIMARY,
                      ),
                    ),
            ],
          ),
          if (hasHeadlineOrBio) ...[
            ySpace(height: 24),
            Container(
              padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                border: Border.all(width: 0.8, color: BORDER),
                color: LIGHT_SECONDARY,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText(
                    "${genUser.headline}",
                    fontSize: 12,
                  ),
                  ySpace(height: 10),
                  subtext(
                    "${genUser.bio}",
                    height: 1.6,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
