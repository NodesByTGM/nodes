import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/event_details.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_event_details_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    this.isFromBusiness = false,
    this.hasDelete = false,
    this.hasSave = false,
    this.isSaved = false,
    required this.event,
  });

  final bool isFromBusiness;
  final bool hasDelete;
  final bool hasSave;
  final bool isSaved;
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: cachedNetworkImage(
                imgUrl: "${event.thumbnail?.url}",
                size: screenWidth(context),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      context.watch<DashboardController>().isSavingUnsavedEvent
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10, right: 15),
                              child: SaveIconLoader(
                                color: WHITE,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                saveUnsaveEvent(context, event);
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SvgPicture.asset(
                                    event.saved
                                        ? ImageUtils.saveJobFilledIcon
                                        : ImageUtils.saveJobIcon,
                                    color: WHITE,
                                  ),
                                ),
                              ),
                            ),
                    ],
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
                Container(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      "${event.name}",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: WHITE,
                      maxLine: 1,
                    ),
                    ySpace(height: 8),
                    subtext(
                      "${shortDate(event.dateTime ?? DateTime.now())} by ${fromDatTimeToTimeOfDay(event.dateTime ?? DateTime.now())}",
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
                          // "Lagos | Nigeria",
                          "${event.location}",
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
                      if (isFromBusiness) {
                        context
                            .read<DashboardController>()
                            .setCurrentlyViewedEvent(event);
                        context.read<NavController>().updatePageListStack(
                              BusinessEventDetailsScreen.routeName,
                            );
                      } else {
                        showEventDetailsBottomSheet(context, event);
                      }
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
        ),
      ],
    );
  }

  saveUnsaveEvent(BuildContext context, EventModel event) async {
    event.saved
        ? await context
            .read<DashboardController>()
            .unSaveEvent(context, event.id)
        : await context
            .read<DashboardController>()
            .saveEvent(context, event.id);
  }

  showEventDetailsBottomSheet(BuildContext context, EventModel event) {
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
                "${event.name}",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: EventDetails(event: event),
            );
          },
        );
      },
    );
  }
}
