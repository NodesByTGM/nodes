// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_event_details_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isDeleting = false;
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
                imgUrl: "${widget.event.thumbnail?.url}",
                size: screenWidth(context),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: BLACK.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // context.watch<DashboardController>().isDeletingEvent
                      isDeleting
                          ? const Loader(
                              color: WHITE,
                            )
                          : GestureDetector(
                              onTap: () => deleteEvent(context, widget.event),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SvgPicture.asset(
                                  ImageUtils.trashOutlineIcon,
                                  color: WHITE,
                                  height: 40,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      "${widget.event.name}",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: WHITE,
                      maxLine: 1,
                    ),
                    ySpace(height: 8),
                    subtext(
                      "${shortDate(widget.event.dateTime ?? DateTime.now())} by ${fromDatTimeToTimeOfDay(widget.event.dateTime ?? DateTime.now())}",
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
                          "${widget.event.location}",
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
                      context
                          .read<DashboardController>()
                          .setCurrentlyViewedEvent(widget.event);
                      context.read<NavController>().updatePageListStack(
                            BusinessEventDetailsScreen.routeName,
                          );
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

  deleteEvent(BuildContext context, EventModel event) async {
    final result = await showAlertDialog(
      context,
      body: subtext(
        "You are about to permanently  delete `${event.name}` Do you want to proceed?",
        fontSize: 13,
      ),
      title: "Delete this event",
      cancelTitle: "No, Cancel",
      okTitle: "Yes, Delete",
      okColor: RED,
      cancelColor: GRAY,
    );
    if (DialogAction.yes == result) {
      // make the api request, delete account, call the logout function, to send them to the auth screen...
      // Delete already existing image behind the scene, no need to hold up the thread...
      setState(() {
        isDeleting = true;
      });
      await context
          .read<DashboardController>()
          .deleteSingleEvent(context, event.id);
      context.read<AuthController>().deleteMedia("${event.thumbnail?.id}");
      setState(() {
        isDeleting = false;
      });
    }
  }
}
