import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

class IndividualDashboardScreen extends StatefulWidget {
  const IndividualDashboardScreen({super.key});
  static const String routeName = "/individual_dashboard_screen";

  @override
  State<IndividualDashboardScreen> createState() =>
      _IndividualDashboardScreenState();
}

class _IndividualDashboardScreenState extends State<IndividualDashboardScreen> {
  late NavController navCtrl;
  int currentJobsIndex = 0;
  int currentTrendingIndex = 0;
  int currentSpaceIndex = 0;
  int jobsLength = 5;
  int trendingLength = 5;
  int spaceLength = 5;
  final jobsCardCtrl = PageController(viewportFraction: 1);
  final trendingCardCtrl = PageController(viewportFraction: 1);
  final spaceCardCtrl = PageController(viewportFraction: 1);

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
              itemCount: jobsLength,
              controller: jobsCardCtrl,
              onPageChanged: (val) {
                currentJobsIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return const EventCard(
                  hasDelete: false,
                  hasSave: true,
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
                  ...List.generate(jobsLength, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentJobsIndex == index,
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
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: jobsLength,
                        currentIndex: currentJobsIndex,
                        ctrl: jobsCardCtrl,
                      );
                    },
                    child: SvgPicture.asset(
                      ImageUtils.leftCircleDirectionIcon,
                    ),
                  ),
                  xSpace(width: 24),
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: true,
                        totoalLength: jobsLength,
                        currentIndex: currentJobsIndex,
                        ctrl: jobsCardCtrl,
                      );
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
                IndividualDashboardViewAllDynamicScreen.routeName,
              );
            },
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.TopMovies,
          ),
          ySpace(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageUtils.multiSpaceEmptyPngIcon),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  color: const Color(0xECFFFFFF),
                  height: 210,
                ),
                Column(
                  children: [
                    labelText(
                      "Want more out of Nodes?",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 16),
                    subtext(
                      "Upgrade your account today and get access to stuff, stuff, stuff, stuff",
                      fontSize: 14,
                      textAlign: TextAlign.center,
                    ),
                    ySpace(height: 40),
                    SizedBox(
                      width: 200,
                      child: SubmitBtn(
                        onPressed: () {},
                        title: btnTxt(
                          "Upgrade your account",
                          WHITE,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ySpace(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Trending obs on Nodes",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: subtext(
                      "See more",
                      fontSize: 14,
                      color: PRIMARY,
                    ),
                  ),
                ],
              )
            ],
          ),
          ySpace(height: 24),
          SizedBox(
            height: 320,
            child: PageView.builder(
              itemCount: trendingLength,
              controller: trendingCardCtrl,
              onPageChanged: (val) {
                currentTrendingIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return const JobCard();
              },
            ),
          ),
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(trendingLength, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentTrendingIndex == index,
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
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: trendingLength,
                        currentIndex: currentTrendingIndex,
                        ctrl: trendingCardCtrl,
                      );
                    },
                    child: SvgPicture.asset(
                      ImageUtils.leftCircleDirectionIcon,
                    ),
                  ),
                  xSpace(width: 24),
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: true,
                        totoalLength: trendingLength,
                        currentIndex: currentTrendingIndex,
                        ctrl: trendingCardCtrl,
                      );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Spaces you might like",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navCtrl.updatePageListStack(
                        NodeSpacesScreen.routeName,
                      );
                    },
                    child: subtext(
                      "See more",
                      fontSize: 14,
                      color: PRIMARY,
                    ),
                  ),
                ],
              )
            ],
          ),
          ySpace(height: 20),
          SizedBox(
            height: 320,
            child: PageView.builder(
              itemCount: spaceLength,
              controller: spaceCardCtrl,
              onPageChanged: (val) {
                currentSpaceIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return CommunitySpaceCardTemplate(
                  imgUrl:
                      "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
                  title: "Lorem ipsum dolor sit amet, con...",
                  height: 300,
                  marginRight: 0,
                  onTap: () {},
                );
              },
            ),
          ),
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(spaceLength, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentSpaceIndex == index,
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
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: spaceLength,
                        currentIndex: currentSpaceIndex,
                        ctrl: spaceCardCtrl,
                      );
                    },
                    child: SvgPicture.asset(
                      ImageUtils.leftCircleDirectionIcon,
                    ),
                  ),
                  xSpace(width: 24),
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: true,
                        totoalLength: spaceLength,
                        currentIndex: currentSpaceIndex,
                        ctrl: spaceCardCtrl,
                      );
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

  customAnimatePageView({
    required bool isInc,
    required int totoalLength,
    required int currentIndex,
    required PageController ctrl,
  }) {
    setState(() {
      if (isInc) {
        // If card has gotten to the last page, then start afresh...
        currentIndex == totoalLength - 1 ? null : currentIndex = ++currentIndex;
      } else {
        // If card is at the beginning, do nothing, else, go a page back...
        currentIndex == 0 ? null : currentIndex = --currentIndex;
      }
    });
    ctrl.animateToPage(
      currentIndex,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}
