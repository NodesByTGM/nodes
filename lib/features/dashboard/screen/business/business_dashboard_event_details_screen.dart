import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/event_details.dart';
import 'package:nodes/features/dashboard/components/saved_event_card.dart';
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
              child: Row(
                children: [
                  labelText(
                    "Name of Event",
                    maxLine: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  actionBtn(
                    icon: ImageUtils.trashOutlineIcon,
                    onTap: () {},
                  ),
                  actionBtn(
                    icon: ImageUtils.editPencileOutlineIcon,
                    onTap: () {},
                  ),
                  actionBtn(
                    icon: ImageUtils.shareOutlineIcon,
                    onTap: () {},
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
                        title: "Saves",
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
                context.read<NavController>().popPageListStack();
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
        return const EventDetails(isFromBusiness: true);
      case 1:
        return const SavedEventCard();
      default:
        return const EventDetails(isFromBusiness: true);
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
