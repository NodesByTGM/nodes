import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/components/saved_events.dart';
import 'package:nodes/features/saves/components/saved_jobs.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class SavedItemScreen extends StatefulWidget {
  const SavedItemScreen({super.key});

  static const String routeName = "/saved_item_screen";

  @override
  State<SavedItemScreen> createState() => _BusinessEventDetailsScreenState();
}

class _BusinessEventDetailsScreenState extends State<SavedItemScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    safeNavigate(
        () => context.read<DashboardController>().fetchAllSavedJobs(context));
    safeNavigate(
        () => context.read<DashboardController>().fetchAllSavedEvents(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 32, bottom: 60),
          children: [
            Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText(
                    "Saves",
                    maxLine: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  ySpace(height: 14),
                  subtext(
                    "Something something about saved jobs and events",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
                        // title: "Jobs (2)",
                        title:
                            "Jobs (${context.watch<DashboardController>().savedJobsList.length})",
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                      ),
                      xSpace(width: 30),
                      tabHeader(
                        isActive: currentIndex == 1,
                        title:
                            "Events (${context.watch<DashboardController>().savedEvents.length})",
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
        return const SavedJobs();
      case 1:
        return const SavedEvents();
      default:
        return const SavedJobs();
    }
  }

  Padding actionBtn({
    required String icon,
    required GestureTapCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          icon,
          height: 30,
        ),
      ),
    );
  }
}
