import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/features/dashboard/screen/dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const String routeName = "/dashboard_screen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late NavController navCtrl;
  int currentIndex = 0;
  int ttLength = 5;
  final cardController = PageController(viewportFraction: 1);

  @override
  void initState() {
    navCtrl = locator.get<NavController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // Can't use ListView here, as it rebuilds the Widget that handles the Future.builder
        // shrinkWrap: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ySpace(height: 40),
          labelText(
            "Welcome to Nodes, Jane ",
            fontSize: 20,
          ),
          ySpace(height: 8),
          subtext(
            "Checkout the blah blah blah blah blah blah",
            fontSize: 14,
          ),
          customDivider(height: 40),
          ySpace(height: 20),
          labelText(
            "Trending",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 8),
          subtext(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
            fontSize: 14,
          ),
          ySpace(height: 24),
          SizedBox(
            height: 368,
            child: PageView.builder(
              itemCount: ttLength,
              controller: cardController,
              onPageChanged: (val) {
                currentIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
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
                      children: [
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(
                              "Lorem ipsum dolor sit amet, con...",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: WHITE,
                              // maxLine: 1,
                            ),
                            ySpace(height: 8),
                            subtext(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                              color: WHITE.withOpacity(0.9),
                              fontSize: 14,
                            ),
                            ySpace(height: 40),
                            GestureDetector(
                              onTap: () {},
                              child: Wrap(
                                spacing: 5,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  labelText(
                                    "Learn more",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: WHITE,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: WHITE,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            ySpace(height: 24),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(ttLength, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentIndex == index,
                      ),
                    );
                  })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      animatePageView(false);
                    },
                    child: SvgPicture.asset(
                      ImageUtils.leftCircleDirectionIcon,
                    ),
                  ),
                  xSpace(width: 24),
                  GestureDetector(
                    onTap: () {
                      animatePageView(true);
                    },
                    child: SvgPicture.asset(
                      ImageUtils.rightCircleDirectionIcon,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ySpace(height: 40),
          Subsection(
            leftSection: "Top Movies",
            rightSection: "View all",
            onTap: () {
              navCtrl.updateDashboardDynamicItem(
                HorizontalSlidingCardDataSource.TopMovies,
              );
              navCtrl.updatePageListStack(
                DashboardViewAllDynamicScreen.routeName,
              );
            },
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.TopMovies,
          ),
          ySpace(height: 40),
          Subsection(
            leftSection: "Hidden Gems",
            rightSection: "View all",
            onTap: () {},
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.HiddenGems,
          ),
          ySpace(height: 40),
          Subsection(
            leftSection: "Flashbacks",
            rightSection: "View all",
            onTap: () {},
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.Flashbacks,
          ),
          ySpace(height: 40),
          Subsection(
            leftSection: "Community",
            rightSection: "Open Community",
            onTap: () {
              navCtrl.updatePageListStack(
                NodeSpacesScreen.routeName,
              );
            },
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.Community,
          ),
          ySpace(height: 40),
          Subsection(
            leftSection: "Collaboration Spotlights",
            rightSection: "View all",
            onTap: () {},
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.CollaborationSpotlights,
          ),
          ySpace(height: 40),
          Subsection(
            leftSection: "Birthdays",
            rightSection: "View all",
            onTap: () {},
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.Birthdays,
          ),
        ],
      ),
    );
  }

  animatePageView(bool isInc) {
    setState(() {
      if (isInc) {
        // If card has gotten to the last page, then start afresh...
        currentIndex == ttLength - 1 ? null : currentIndex = ++currentIndex;
      } else {
        // If card is at the beginning, do nothing, else, go a page back...
        currentIndex == 0 ? null : currentIndex = --currentIndex;
      }
    });
    cardController.animateToPage(
      currentIndex,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}
