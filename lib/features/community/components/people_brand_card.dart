import 'package:nodes/features/community/models/general_user_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/messages/screen/single_message_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class PeopleBrandCard extends StatefulWidget {
  const PeopleBrandCard({
    super.key,
    this.isConnected = false,
    required this.genUser,
  });

  final bool isConnected;
  final GeneralUserModel genUser;

  @override
  State<PeopleBrandCard> createState() => _PeopleBrandCardState();
}

class _PeopleBrandCardState extends State<PeopleBrandCard> {
  bool isConnecting = false;

  @override
  Widget build(BuildContext context) {
    List<String> usersType = ["Standard", "Pro", "Business"];

    bool hasHeadlineOrBio = !isObjectEmpty(widget.genUser.headline) ||
        !isObjectEmpty(widget.genUser.bio);

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
                imgUrl: "${widget.genUser.avatar?.url}",
                size: 45,
              ),
              xSpace(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      capitalize("${widget.genUser.name}"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    subtext(
                      "${usersType[widget.genUser.type]} User",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GRAY,
                    ),
                  ],
                ),
              ),
              xSpace(width: 10),
              // context.watch<ComController>().isRequestingConnection
              isConnecting
                  ? const Loader()
                  : GestureDetector(
                      onTap: () async {
                        if (widget.isConnected) {
                          // probably fetch the user something before sending them here...
                          navigateTo(context, SingleMessageDetails.routeName);
                        } else {
                          // Function to Connect with user/brand
                          setState(() {
                            isConnecting = true;
                          });
                          await context.read<ComController>().requestConnection(
                                context,
                                "${widget.genUser.id}",
                              );
                          setState(() {
                            isConnecting = false;
                          });
                        }
                      },
                      child: labelText(
                        widget.isConnected ? "Message" : "Connect",
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
                    "${widget.genUser.headline}",
                    fontSize: 12,
                  ),
                  ySpace(height: 10),
                  subtext(
                    "${widget.genUser.bio}",
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
