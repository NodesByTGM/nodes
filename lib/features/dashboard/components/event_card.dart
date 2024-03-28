import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/event_details.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_event_details_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    this.isFromBusiness = false,
    this.hasDelete = false,
    this.hasSave = false,
    this.isSaved = false,
  });

  final bool isFromBusiness;
  final bool hasDelete;
  final bool hasSave;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: const NetworkImage(
              "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            // Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.4),
            BlendMode.multiply,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // if (hasDelete || hasSave)
            if (hasSave)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    isSaved
                        ? ImageUtils.saveJobFilledIcon
                        : ImageUtils.saveJobIcon,
                    color: WHITE,
                  ),
                ),
              ),
            if (hasDelete)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    ImageUtils.trashOutlineIcon,
                    color: WHITE,
                    height: 40,
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Name of event",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: WHITE,
                  maxLine: 1,
                ),
                ySpace(height: 8),
                subtext(
                  "Date & Time",
                  color: WHITE,
                  fontSize: 14,
                ),
                ySpace(height: 24),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: WHITE,
                    ),
                    subtext(
                      "Lagos | Nigeria",
                      color: WHITE.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
            // ySpace(height: 40),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  isFromBusiness
                      ? context.read<NavController>().updatePageListStack(
                            BusinessEventDetailsScreen.routeName,
                          )
                      : showEventDetailsBottomSheet(context);
                },
                child: labelText(
                  "View details",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: WHITE,
                ),
              ),
            ),
            ySpace(height: 24),
          ],
        ),
      ),
    );
  }

  showEventDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      backgroundColor: WHITE,
      elevation: 0.0,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "Event Name",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: const EventDetails(),
            );
          },
        );
      },
    );
  }
}
