// ignore_for_file: use_build_context_synchronously

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/components/create_event.dart';
import 'package:nodes/features/dashboard/components/event_details.dart';
import 'package:nodes/features/dashboard/components/saved_event_applicant_card.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BusinessEventDetailsScreen extends StatefulWidget {
  const BusinessEventDetailsScreen({super.key});

  static const String routeName = "/business_dashboard_event_details_screen";

  @override
  State<BusinessEventDetailsScreen> createState() =>
      _BusinessEventDetailsScreenState();
}

class _BusinessEventDetailsScreenState
    extends State<BusinessEventDetailsScreen> {
  int currentIndex = 0;

  late DashboardController dashCtrl;
  late EventModel event;
  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    event = dashCtrl.currentlyViewedBusinessEvent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    event = dashCtrl.currentlyViewedBusinessEvent;
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 32, bottom: 60),
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  labelText(
                    capitalize("${event.name}"),
                    maxLine: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  actionBtn(
                    icon: ImageUtils.trashOutlineIcon,
                    onTap: () => deleteEvent(context, event),
                    loading:
                        context.watch<DashboardController>().isDeletingEvent,
                  ),
                  actionBtn(
                    icon: ImageUtils.editPencileOutlineIcon,
                    onTap: showEditEventBottomSheet,
                    loading:
                        context.watch<DashboardController>().isUpdatingEvent,
                  ),
                  actionBtn(
                    icon: ImageUtils.shareOutlineIcon,
                    onTap: () async {
                      await shareDoc(
                        context,
                        url: "$nodeWebsite/${event.name}",
                      );
                    },
                    loading: false,
                  ),
                ],
              ),
            ),
            ySpace(height: 32),
            StickyHeaderBuilder(
              builder: (context, stuckAmount) {
                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  // color: stuckAmount <= -0.54 ? WHITE : null,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: BORDER),
                    ),
                    color: WHITE,
                  ),
                  child: Row(
                    children: [
                      tabHeader(
                        isActive: currentIndex == 0,
                        title: "Details",
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                      ),
                      xSpace(width: 30),
                      tabHeader(
                        isActive: currentIndex == 1,
                        title: "Saves (${event.saves?.length})",
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
              content: Container(
                color: PROFILEBG,
                padding: screenPadding,
                margin: const EdgeInsets.only(bottom: 60),
                child: getTabBody(),
              ),
            ),
          ],
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
    );
  }

  getTabBody() {
    switch (currentIndex) {
      case 0:
        return EventDetails(
          event: event,
        );
      case 1:
        return SavedEventApplicantCard(event: event);
      default:
        return EventDetails(
          event: event,
        );
    }
  }

  deleteEvent(BuildContext context, EventModel event) async {
    final result = await showAlertDialog(
      context,
      body: subtext(
        "Are you sure you want to delete this Event posting?",
        fontSize: 13,
      ),
      title: "Delete Event",
      cancelTitle: "No, Cancel",
      okTitle: "Yes, Delete",
      okColor: RED,
      cancelColor: GRAY,
    );
    if (DialogAction.yes == result) {
      // make the api request, delete account, call the logout function, to send them to the auth screen...
      bool done = await context
          .read<DashboardController>()
          .deleteSingleEvent(context, event.id);

      if (done && mounted) {
        customNavigateBack(context);
      }
    }
  }

  showEditEventBottomSheet() {
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
        return BottomSheetWrapper(
          closeOnTap: true,
          title: labelText(
            "Edit Event",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          // pass the event
          child: CreateEvent(
            event: event,
          ),
        );
      },
    );
  }
}
