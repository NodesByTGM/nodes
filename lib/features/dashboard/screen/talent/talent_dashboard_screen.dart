import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_view_all_jobs.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/quick_setup_card.dart';

class TalentDashboardScreen extends StatefulWidget {
  const TalentDashboardScreen({super.key});
  static const String routeName = "/talent_dashboard_screen";

  @override
  State<TalentDashboardScreen> createState() => _TalentDashboardScreenState();
}

class _TalentDashboardScreenState extends State<TalentDashboardScreen> {
  late NavController navCtrl;
  int jobLength = 5;
  int spaceLength = 5;
  int trendingLength = 5;
  int jobsForYouLength = 5;
  int currentJobsIndex = 0;
  int currentSpaceIndex = 0;
  int currentTrendingIndex = 0;
  int currentJobIndex = 0;
  final trendingCtrl = PageController(viewportFraction: 1);
  final jobsCardCtrl = PageController(viewportFraction: 1);
  final spaceCardCtrl = PageController(viewportFraction: 1);
  final jobsForYouCtrl = PageController(viewportFraction: 1);

  @override
  void initState() {
    navCtrl = locator.get<NavController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // gradient: profileLinearGradient,
          // color: RED,
          ),
      child: ListView(
        children: [
          ySpace(height: 40),
          labelText(
            "Hi, Jane Nice to have you here.",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          customDivider(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 26,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PRIMARY,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Welcome to Nodes! ",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: WHITE,
                ),
                ySpace(height: 10),
                subtext(
                  "You now have access to a creative ecosystem, follow spaces, connect with the community and access job opportunities",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: WHITE,
                ),
                ySpace(height: 40),
                QuickSetupCard(
                  title: "Complete your\nprofile",
                  btnTitle: "Complete Profile",
                  icon: ImageUtils.headIcon,
                  onTap: () {},
                ),
                ySpace(height: 24),
                QuickSetupCard(
                  title: "Connect with\nothers",
                  btnTitle: "Discover",
                  icon: ImageUtils.thrunkIcon,
                  onTap: () {},
                ),
                ySpace(height: 24),
                QuickSetupCard(
                  title: "Find your\nnext job",
                  btnTitle: "Browse jobs",
                  icon: ImageUtils.legsIcon,
                  onTap: () {},
                ),
              ],
            ),
          ),
          ySpace(height: 72),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Jobs you have applied to",
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
                    onTap: () {
                      navCtrl.updatePageListStack(
                        TalentJobCenterScreen.routeName,
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
          ySpace(height: 24),
          SizedBox(
            height: 320,
            child: PageView.builder(
              itemCount: jobLength,
              controller: jobsCardCtrl,
              onPageChanged: (val) {
                currentJobIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return  JobCard(job: JobModel(),);
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
                  ...List.generate(jobLength, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentJobIndex == index,
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
                        totoalLength: jobLength,
                        currentIndex: currentJobIndex,
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
                        totoalLength: jobLength,
                        currentIndex: currentJobIndex,
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
          ySpace(height: 72),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Jobs for you",
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
              itemCount: jobsForYouLength,
              controller: jobsForYouCtrl,
              onPageChanged: (val) {
                currentJobsIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return  JobCard(job: JobModel(),);
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
                  ...List.generate(jobsForYouLength, (index) {
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
                        totoalLength: jobsForYouLength,
                        currentIndex: currentJobsIndex,
                        ctrl: jobsForYouCtrl,
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
                        totoalLength: jobsForYouLength,
                        currentIndex: currentJobsIndex,
                        ctrl: jobsForYouCtrl,
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
          ySpace(height: 72),
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
          ySpace(height: 72),
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
              itemCount: trendingLength,
              controller: trendingCtrl,
              onPageChanged: (val) {
                currentTrendingIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return  EventCard(
                  hasDelete: false,
                  hasSave: true,
                  event: EventModel(),
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
                        ctrl: trendingCtrl,
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
                        ctrl: trendingCtrl,
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
