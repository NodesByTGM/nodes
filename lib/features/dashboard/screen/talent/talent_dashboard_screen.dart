import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';
import 'package:nodes/features/dashboard/components/event_card_standardTalent.dart';
import 'package:nodes/features/dashboard/components/job_card_standardTalent.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_view_all_applied_jobs.dart';
import 'package:nodes/features/dashboard/screen/talent/talent_dashboard_view_all_jobs.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/screens/profile_wrapper.dart';
import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/quick_setup_card.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class TalentDashboardScreen extends StatefulWidget {
  const TalentDashboardScreen({super.key});
  static const String routeName = "/talent_dashboard_screen";

  @override
  State<TalentDashboardScreen> createState() => _TalentDashboardScreenState();
}

class _TalentDashboardScreenState extends State<TalentDashboardScreen> {
  late NavController navCtrl;
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late UserModel user;
  int spaceLength = 5;
  int currentJobsForYouIndex = 0;
  int currentSpaceIndex = 0;
  int currentTrendingIndex = 0;
  int currentAppliedJobsIndex = 0;
  final trendingCtrl = PageController(viewportFraction: 1);
  final appliedJobsCtrl = PageController(viewportFraction: 1);
  final spaceCardCtrl = PageController(viewportFraction: 1);
  final jobsForYouCtrl = PageController(viewportFraction: 1);

  @override
  void initState() {
    navCtrl = locator.get<NavController>();
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    user = authCtrl.currentUser;
    super.initState();
    fetchJobsEventsTrending();
  }

  fetchJobsEventsTrending() {
    fetchAllJobs();
    fetchAllAppliedJobs();
    fetchAllEvents();
    fetchAllTrending();
  }

  fetchAllJobs() {
    safeNavigate(() => dashCtrl.fetchAllJobs(context));
  }

  fetchAllAppliedJobs() {
    safeNavigate(() => dashCtrl.fetchAllAppliedJobs(context));
  }

  fetchAllEvents() {
    safeNavigate(() => dashCtrl.fetchAllEvents(context));
  }

  fetchAllTrending() {
    safeNavigate(() => dashCtrl.fetchTrending(context));
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    dashCtrl = context.watch<DashboardController>();
    return Container(
      decoration: const BoxDecoration(
          // gradient: profileLinearGradient,
          // color: RED,
          ),
      child: ListView(
        children: [
          ySpace(height: 40),
          labelText(
            "Hi  ${user.name?.split(' ').first}!, Nice to have you here.",
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
              color: TAG_CHIP,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Welcome to Nodes! ",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 10),
                subtext(
                  "You now have access to a creative ecosystem, follow spaces, connect with the community and access job opportunities",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 40),
                if (!isTalentProfileComplete(user)) ...[
                  QuickSetupCard(
                    title: "Complete your\nprofile",
                    btnTitle: "Complete Profile",
                    icon: ImageUtils.headIcon,
                    borderColor: TAG_CHIP,
                    onTap: () {
                      navCtrl.updatePageListStack(ProfileWrapper.routeName);
                    },
                  ),
                  ySpace(height: 24),
                ],
                QuickSetupCard(
                  title: "Connect with\nothers",
                  btnTitle: "Discover",
                  icon: ImageUtils.thrunkIcon,
                  borderColor: TAG_CHIP,
                  onTap: () {
                    navCtrl.updatePageListStack(NodeCommunityScreen.routeName);
                  },
                ),
                ySpace(height: 24),
                QuickSetupCard(
                  title: "Find your\nnext job",
                  btnTitle: "Browse jobs",
                  icon: ImageUtils.legsIcon,
                  borderColor: TAG_CHIP,
                  onTap: () {
                    navCtrl.updatePageListStack(
                      TalentJobCenterScreen.routeName,
                    );
                  },
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
                        TalentAppliedJobCenterScreen.routeName,
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
          Consumer<DashboardController>(
            builder: (contex, dCtrl, _) {
              bool isLoading = dCtrl.isFetchingAllAppliedJobs;
              bool hasData = isObjectEmpty(dCtrl.appliedJobsList);
              if (isLoading || isObjectEmpty(dCtrl.appliedJobsList)) {
                return DataReload(
                  maxHeight: screenHeight(context) * .19,
                  isLoading: isLoading,
                  label: "Oops!! you haven't applied  for any jobs yet.",
                  loader: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerLoader(
                      scrollDirection: Axis.horizontal,
                      width: screenWidth(context),
                      marginBottom: 10,
                    ),
                  ),
                  onTap: fetchAllAppliedJobs,
                  isEmpty: hasData,
                );
              } else {
                List<StandardTalentJobModel> appliedJobsList =
                    dCtrl.appliedJobsList;
                return SizedBox(
                  height: 320,
                  child: PageView.builder(
                    itemCount: appliedJobsList.length,
                    controller: appliedJobsCtrl,
                    onPageChanged: (val) {
                      currentAppliedJobsIndex = val;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      StandardTalentJobModel job = appliedJobsList[index];
                      return StandardTalentJobCard(
                        job: job,
                        id: "${job.id}",
                      );
                    },
                  ),
                );
              }
            },
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(dashCtrl.appliedJobsList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentAppliedJobsIndex == index,
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
                        totoalLength: dashCtrl.appliedJobsList.length,
                        currentIndex: currentAppliedJobsIndex,
                        ctrl: appliedJobsCtrl,
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
                        totoalLength: dashCtrl.appliedJobsList.length,
                        currentIndex: currentAppliedJobsIndex,
                        ctrl: appliedJobsCtrl,
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
          Consumer<DashboardController>(
            builder: (contex, dCtrl, _) {
              bool isLoading = dCtrl.isFetchingAllJob;
              bool hasData = isObjectEmpty(dCtrl.jobsList);
              if (isLoading || isObjectEmpty(dCtrl.jobsList)) {
                return DataReload(
                  maxHeight: screenHeight(context) * .19,
                  isLoading: isLoading,
                  label: "Oops!! No listed jobs yet.",
                  loader: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerLoader(
                      scrollDirection: Axis.horizontal,
                      width: screenWidth(context),
                      marginBottom: 10,
                    ),
                  ),
                  onTap: fetchAllAppliedJobs,
                  isEmpty: hasData,
                );
              } else {
                List<StandardTalentJobModel> jobsList = dCtrl.jobsList;
                return SizedBox(
                  height: 320,
                  child: PageView.builder(
                    itemCount: jobsList.length,
                    controller: jobsForYouCtrl,
                    onPageChanged: (val) {
                      currentJobsForYouIndex = val;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      StandardTalentJobModel job = jobsList[index];
                      return StandardTalentJobCard(
                        job: job,
                        id: "${job.id}",
                      );
                    },
                  ),
                );
              }
            },
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(dashCtrl.jobsList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: CardDotIndicator(
                        isActive: currentJobsForYouIndex == index,
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
                        totoalLength: dashCtrl.jobsList.length,
                        currentIndex: currentJobsForYouIndex,
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
                        totoalLength: dashCtrl.jobsList.length,
                        currentIndex: currentJobsForYouIndex,
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
                      // navCtrl.updatePageListStack(
                      //   NodeSpacesScreen.routeName,
                      // );
                      showSuccess(message: "Coming Soon");
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
            "Trending Events",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 8),
          subtext(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
            fontSize: 14,
          ),
          ySpace(height: 24),
          Consumer<DashboardController>(
            builder: (contex, dCtrl, _) {
              bool isLoading = dCtrl.isFetchingAllEvent;
              bool hasData = isObjectEmpty(dCtrl.eventsList);
              if (isLoading || isObjectEmpty(dCtrl.eventsList)) {
                return DataReload(
                  maxHeight: screenHeight(context) * .19,
                  isLoading: isLoading,
                  label: "Oops!! Trending events yet.",
                  loader: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerLoader(
                      scrollDirection: Axis.horizontal,
                      width: screenWidth(context),
                      marginBottom: 10,
                    ),
                  ),
                  onTap: fetchAllAppliedJobs,
                  isEmpty: hasData,
                );
              } else {
                List<StandardTalentEventModel> eventsList = dCtrl.eventsList;
                return SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: eventsList.length,
                    controller: trendingCtrl,
                    onPageChanged: (val) {
                      currentTrendingIndex = val;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return StandardTalentEventCard(
                        hasDelete: false,
                        hasSave: false,
                        event: eventsList[index],
                      );
                    },
                  ),
                );
              }
            },
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(dashCtrl.eventsList.length, (index) {
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
                        totoalLength: dashCtrl.eventsList.length,
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
                        totoalLength: dashCtrl.eventsList.length,
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
