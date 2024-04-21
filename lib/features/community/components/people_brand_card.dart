import 'package:nodes/features/messages/screen/single_message_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class PeopleBrandCard extends StatelessWidget {
  const PeopleBrandCard({
    super.key,
    this.isConnected = false,
  });

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
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
                imgUrl: "",
                size: 45,
              ),
              xSpace(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      capitalize("Aderinsola Adejuwon"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    subtext(
                      "Pro User",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GRAY,
                    ),
                  ],
                ),
              ),
              xSpace(width: 10),
              GestureDetector(
                onTap: () {
                  if (isConnected) {
                    // navigateTo(context, MessageScreen.routeName);
                    // probably fetch the user something before sending them here...
                    navigateTo(context, SingleMessageDetails.routeName);
                  } else {
                    // Function to Connect with user/brand
                  }
                },
                child: labelText(
                  isConnected ? "Message" : "Connect",
                  color: PRIMARY,
                ),
              ),
            ],
          ),
          ySpace(height: 24),
          Container(
            padding: const EdgeInsets.all(8),
            width: screenWidth(context),
            decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: BORDER),
              color: TAG_CHIP.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Production assistant",
                  fontSize: 12,
                ),
                ySpace(height: 10),
                subtext(
                  "Something about being an amazing media production company and like stuff something smoething",
                  height: 1.6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
