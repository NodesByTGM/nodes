// ignore_for_file: file_names, deprecated_member_use

import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/event_details_standardTalent.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class StandardTalentEventCard extends StatefulWidget {
  const StandardTalentEventCard({
    super.key,
    required this.event,
  });

  final StandardTalentEventModel event;

  @override
  State<StandardTalentEventCard> createState() =>
      _StandardTalentEventCardState();
}

class _StandardTalentEventCardState extends State<StandardTalentEventCard> {
  ValueNotifier<bool> isSavingEvent = ValueNotifier(false);

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    bool canSave = context.read<AuthController>().currentUser.type == 1 ||
        context.read<AuthController>().currentUser.type == 2;
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // Add an overlay on this image please...
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // context.watch<DashboardController>().isSavingUnsavedEvent
                    isSaving
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10, right: 15),
                            child: SaveIconLoader(
                              color: WHITE,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              // check if user is standard and prompt them to upgrade
                              if (canSave) {
                                setState(() {
                                  isSaving = true;
                                });
                                await saveUnsaveEvent(context, widget.event);
                                setState(() {
                                  isSaving = false;
                                });
                              } else {
                                showText(
                                  message:
                                      "Oops!! You have to upgrade to PRO to have this feature.",
                                );
                              }
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SvgPicture.asset(
                                  widget.event.saved
                                      ? ImageUtils.saveJobFilledIcon
                                      : ImageUtils.saveJobIcon,
                                  color: WHITE,
                                ),
                              ),
                            ),
                          ),
                  ],
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
                      showEventDetailsBottomSheet(context, widget.event);
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

  saveUnsaveEvent(BuildContext context, StandardTalentEventModel event) async {
    event.saved
        ? await context
            .read<DashboardController>()
            .unSaveEvent(context, event.id)
        : await context
            .read<DashboardController>()
            .saveEvent(context, event.id);
  }

  showEventDetailsBottomSheet(
      BuildContext context, StandardTalentEventModel event) {
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
              child: StandardTalentEventDetails(event: event),
            );
          },
        );
      },
    );
  }
}
