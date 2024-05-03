import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/comment_section.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

class IndividualDashboardSingleItemDetailsScreen extends StatefulWidget {
  const IndividualDashboardSingleItemDetailsScreen({super.key});
  static const String routeName = "/individual_dashboard_single_item_details";

  @override
  State<IndividualDashboardSingleItemDetailsScreen> createState() =>
      _IndividualDashboardSingleItemDetailsScreenState();
}

class _IndividualDashboardSingleItemDetailsScreenState
    extends State<IndividualDashboardSingleItemDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // will be using another controller instead of auth, for making the API calls...
    return Consumer2<NavController, DashboardController>(
      builder: (context, navCtrl, dashCtrl, _) {
        return Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ySpace(height: 40),
                GestureDetector(
                  onTap: () {
                    navCtrl.popPageListStack();
                  },
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_left,
                      ),
                      labelText(
                        "Go back",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                ySpace(height: 40),
                subtext(
                  "Top Movies",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                ySpace(height: 24),
                labelText(
                  "Lorem ipsum dolor sit amet, consectetur.",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                ySpace(height: 8),
                subtext(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                ySpace(height: 40),
                Container(
                  height: 340,
                  decoration: BoxDecoration(
                    color: GRAY,
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(ImageUtils.appIcon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ySpace(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: subtext(
                    "Posted on ${fullDate(DateTime.now())}",
                    fontSize: 12,
                  ),
                ),
                ySpace(height: 40),
                const Subsection(
                  leftSection: "More like this",
                ),
                // run the list with the dataList from controller
                const HorizontalSlidingCards(
                  dataSource: HorizontalSlidingCardDataSource.MoreLikeThis,
                ),
                ySpace(height: 180),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth(context),
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                decoration: const BoxDecoration(
                  color: WHITE,
                  border: Border(
                    top: BorderSide(width: 0.7, color: BORDER),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: labelText(
                        "What do you think?",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      trailing: Wrap(
                        spacing: 20,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          socialInteractionIconWithVal(
                            content: "32",
                            icon: Icons.favorite_outline,
                            iconSize: 32,
                            textSize: 16,
                            color: PRIMARY,
                            onTap: () {},
                          ),
                          socialInteractionIconWithVal(
                            content: "32",
                            icon: Icons.comment_outlined,
                            iconSize: 32,
                            textSize: 16,
                            color: PRIMARY,
                            onTap: () => showCommentBottomSheet(),
                          ),
                          const SizedBox.shrink()
                        ],
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Container(
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: PRIMARY,
                        ),
                        child: Center(
                          child: labelText(
                            "AA",
                            fontSize: 16,
                            color: WHITE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.7, color: BORDER),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GestureDetector(
                          onTap: () => showCommentBottomSheet(),
                          child: subtext(
                            "Add a comment",
                          ),
                        ),
                      ),
                      trailing: const SizedBox.shrink(),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// Save yourself the hassle, and have this as a separate stateful widget file
// Add focus, so that once it opens, the keypad opens also...
  showCommentBottomSheet() {
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
                "Comments (20)",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: const CommentSection(),
            );
          },
        );
      },
    );
  }
}
