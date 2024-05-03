import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/models/community_post_model.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/features/dashboard/components/job_card_standardTalent.dart';
import 'package:nodes/features/dashboard/components/trending_news_card.dart';
import 'package:nodes/features/dashboard/model/trending_model.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/features/subscriptions/screen/subscription_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/card_dot_generator.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class IndividualDashboardScreen extends StatefulWidget {
  const IndividualDashboardScreen({super.key});
  static const String routeName = "/individual_dashboard_screen";

  @override
  State<IndividualDashboardScreen> createState() =>
      _IndividualDashboardScreenState();
}

class _IndividualDashboardScreenState extends State<IndividualDashboardScreen> {
  late NavController navCtrl;
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late ComController cCtrl;
  late UserModel user;
  int currentTrendingNewsIndex = 0;
  int currentTrendingIndex = 0;
  int currentPostIndex = 0;
  final trendingNewsCardCtrl = PageController(viewportFraction: 1);
  final trendingCardCtrl = PageController(viewportFraction: 1);
  final postCardCtrl = PageController(viewportFraction: 1);

  @override
  void initState() {
    navCtrl = locator.get<NavController>();
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    cCtrl = locator.get<ComController>();
    user = authCtrl.currentUser;
    super.initState();
    fetchJobsEventsTrendingPosts();
  }

  fetchJobsEventsTrendingPosts() {
    fetchTrendingNews();
    fetchAllJobs();
    fetchAllPosts();
  }

  fetchAllJobs() {
    safeNavigate(() => dashCtrl.fetchAllJobs(context));
  }

  fetchTrendingNews() {
    safeNavigate(() => dashCtrl.fetchTrendingNews(context));
  }

  fetchAllPosts() {
    safeNavigate(() => context.read<ComController>().fetchAllPosts(context));
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    dashCtrl = context.watch<DashboardController>();
    cCtrl = context.watch<ComController>();
    return SingleChildScrollView(
      child: Column(
        // Can't use ListView here, as it rebuilds the Widget that handles the Future.builder
        // shrinkWrap: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ySpace(height: 40),
          labelText(
            "Welcome to Nodes, ${user.name?.split(' ').first ?? ''} ",
            fontSize: 20,
          ),
          ySpace(height: 8),
          subtext(
            "Discover all the cool things waiting for you to tap into",
            fontSize: 14,
          ),
          customDivider(height: 40),
          ySpace(height: 20),

          // <<<< ========= TRENDING NEWS STARTS HERE ============ >>>>>>>
          labelText(
            "Trending",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          ySpace(height: 8),
          subtext(
            "Stay in the loop with what's buzzing in the creative world.",
            fontSize: 14,
          ),
          ySpace(height: 24),
          Consumer<DashboardController>(
            builder: (contex, dCtrl, _) {
              bool isLoading = dCtrl.isFetchTrendingNews;
              bool hasData = isObjectEmpty(dCtrl.trendingNewsList);
              if (isLoading || isObjectEmpty(dCtrl.trendingNewsList)) {
                return DataReload(
                  maxHeight: screenHeight(context) * .19,
                  isLoading: isLoading,
                  loader: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerLoader(
                      scrollDirection: Axis.horizontal,
                      width: screenWidth(context),
                      marginBottom: 10,
                    ),
                  ),
                  onTap: fetchTrendingNews,
                  isEmpty: hasData,
                );
              } else {
                List<TrendingNewsModel> trendingNewsList =
                    dCtrl.trendingNewsList;
                return SizedBox(
                  height: 320,
                  child: PageView.builder(
                    itemCount: trendingNewsList.length > 5
                        ? 5
                        : trendingNewsList.length,
                    controller: trendingNewsCardCtrl,
                    onPageChanged: (val) {
                      currentTrendingNewsIndex = val;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      TrendingNewsModel tNews = trendingNewsList[index];
                      return TrendingNewsCard(
                        news: tNews,
                      );
                    },
                  ),
                );
              }
            },
          ),
          ySpace(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardDotGenerator(
                length: dashCtrl.trendingNewsList.length > 5
                    ? 5
                    : dashCtrl.trendingNewsList.length,
                // length: dashCtrl.trendingNewsList.length,
                currentIndex: currentTrendingNewsIndex,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: dashCtrl.trendingNewsList.length > 5
                            ? 5
                            : dashCtrl.trendingNewsList.length,
                        // totoalLength: dashCtrl.trendingNewsList.length,
                        currentIndex: currentTrendingNewsIndex,
                        ctrl: trendingNewsCardCtrl,
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
                        totoalLength: dashCtrl.trendingNewsList.length > 5
                            ? 5
                            : dashCtrl.trendingNewsList.length,
                        currentIndex: currentTrendingNewsIndex,
                        ctrl: trendingNewsCardCtrl,
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
          // <<<< ========= TRENDING NEWS ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= TOP MOVIES STARTS HERE ============ >>>>>>>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Top Movies",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "What did you think? Rate and share your review",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navCtrl.updateDashboardDynamicItem(
                        HorizontalSlidingCardDataSource.TopMovies,
                      );
                      navCtrl.updatePageListStack(
                        IndividualDashboardViewAllDynamicScreen.routeName,
                      );
                    },
                    child: subtext(
                      "View all",
                      fontSize: 14,
                      color: PRIMARY,
                    ),
                  ),
                ],
              ),
              customDivider(),
            ],
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.TopMovies,
          ),
          // <<<< ========= TOP MOVIES ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= UPGRADE ACCOUNT STARTS HERE ============ >>>>>>>
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
                      width: 300,
                      child: SubmitBtn(
                        onPressed: () {
                          context.read<NavController>().updatePageListStack(
                                SubscriptionScreen.routeName,
                              );
                        },
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
          // <<<< ========= UPGRADE ACCOUNT ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= JOB LISTING STARTS HERE ============ >>>>>>>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Trending jobs on Nodes",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "Local and international gigs for you",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showText(message: "Upgrade to Pro to see more");
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
                  loader: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerLoader(
                      scrollDirection: Axis.horizontal,
                      width: screenWidth(context),
                      marginBottom: 10,
                    ),
                  ),
                  onTap: fetchAllJobs,
                  isEmpty: hasData,
                );
              } else {
                List<StandardTalentJobModel> jobsList = dCtrl.jobsList;
                return SizedBox(
                  height: 320,
                  child: PageView.builder(
                    itemCount: jobsList.length > 5 ? 5 : jobsList.length,
                    controller: trendingCardCtrl,
                    onPageChanged: (val) {
                      currentTrendingIndex = val;
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
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardDotGenerator(
                length:
                    dashCtrl.jobsList.length > 5 ? 5 : dashCtrl.jobsList.length,
                currentIndex: currentTrendingIndex,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: dashCtrl.jobsList.length > 5
                            ? 5
                            : dashCtrl.jobsList.length,
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
                        totoalLength: dashCtrl.jobsList.length > 5
                            ? 5
                            : dashCtrl.jobsList.length,
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
          // <<<< ========= JOB LISTING ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= BIRTHDAYS STARTS HERE ============ >>>>>>>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Birthday",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "You'll love this!",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navCtrl.updateDashboardDynamicItem(
                        HorizontalSlidingCardDataSource.Birthdays,
                      );
                      navCtrl.updatePageListStack(
                        IndividualDashboardViewAllDynamicScreen.routeName,
                      );
                    },
                    child: subtext(
                      "View all",
                      fontSize: 14,
                      color: PRIMARY,
                    ),
                  ),
                ],
              ),
              customDivider(),
            ],
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.Birthdays,
          ),
          // <<<< ========= BIRTHDAYS ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= FLASHBACKS STARS HERE ============ >>>>>>>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Flash Backs",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "Previously on Nodes",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navCtrl.updateDashboardDynamicItem(
                        HorizontalSlidingCardDataSource.TopMovies,
                      );
                      navCtrl.updatePageListStack(
                        IndividualDashboardViewAllDynamicScreen.routeName,
                      );
                    },
                    child: subtext(
                      "View all",
                      fontSize: 14,
                      color: PRIMARY,
                    ),
                  ),
                ],
              ),
              customDivider(),
            ],
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.Flashbacks,
          ),
          // <<<< ========= FLASHBACKS ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= COMMUNITY STARTS HERE ============ >>>>>>>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Community",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 10),
              Row(
                children: [
                  Expanded(
                    child: subtext(
                      "Join the conversation and\nconnect with your tribe",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navCtrl.updatePageListStack(
                        NodeCommunityScreen.routeName,
                      );
                    },
                    child: subtext(
                      "See more",
                      fontSize: 14,
                      color: PRIMARY,
                    ),
                  ),
                ],
              ),
              customDivider(),
            ],
          ),
          ySpace(height: 20),
          Consumer<ComController>(
            builder: (contex, cCtrl, _) {
              bool isLoading = cCtrl.isFetchingPost;
              bool hasData = isObjectEmpty(cCtrl.postList);
              if (isLoading || isObjectEmpty(cCtrl.postList)) {
                return DataReload(
                  maxHeight: screenHeight(context) * .19,
                  isLoading: isLoading,
                  label: "Oops!! No Community posts yet.",
                  loader: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerLoader(
                      scrollDirection: Axis.horizontal,
                      width: screenWidth(context),
                      marginBottom: 10,
                    ),
                  ),
                  onTap: fetchAllPosts,
                  isEmpty: hasData,
                );
              } else {
                List<PostModel> postList = cCtrl.postList;
                return SizedBox(
                  height: 150,
                  // height: 320,
                  child: PageView.builder(
                    itemCount: postList.length > 5 ? 5 : postList.length,
                    controller: postCardCtrl,
                    onPageChanged: (val) {
                      currentPostIndex = val;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      PostModel post = postList[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.7, color: BORDER),
                          color: WHITE,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: PRIMARY,
                                  child: labelText(
                                      getShortName(
                                        "${post.author?.name?.split(" ").first}",
                                      ),
                                      color: WHITE),
                                ),
                                xSpace(width: 10),
                                Expanded(
                                  child: labelText(
                                    capitalize("${post.author?.name}"),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                xSpace(width: 10),
                                subtext(
                                  shortTime(post.createdAt ?? DateTime.now()),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: GRAY,
                                ),
                              ],
                            ),
                            ySpace(height: 20),
                            labelText(
                              "${post.body}",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              maxLine: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardDotGenerator(
                length: cCtrl.postList.length > 5 ? 5 : cCtrl.postList.length,
                currentIndex: currentPostIndex,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: cCtrl.postList.length > 5
                            ? 5
                            : cCtrl.postList.length,
                        currentIndex: currentPostIndex,
                        ctrl: postCardCtrl,
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
                        totoalLength: cCtrl.postList.length > 5
                            ? 5
                            : cCtrl.postList.length,
                        currentIndex: currentPostIndex,
                        ctrl: postCardCtrl,
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
          // <<<< ========= COMMUNITY ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= COLLABORATION SPOTLIGHT STARTS HERE ============ >>>>>>>
          Subsection(
            leftSection: "Collaboration Spotlights",
            rightSection: "View all",
            onTap: () {
              navCtrl.updateDashboardDynamicItem(
                HorizontalSlidingCardDataSource.CollaborationSpotlights,
              );
              navCtrl.updatePageListStack(
                IndividualDashboardViewAllDynamicScreen.routeName,
              );
            },
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.CollaborationSpotlights,
          ),
          // <<<< ========= COLLABORATION SPOTLIGHT ENDS HERE ============ >>>>>>>

          ySpace(height: 40),

          // <<<< ========= HIDDEN GEM STARTS HERE ============ >>>>>>>
          Subsection(
            leftSection: "Hiddedn Gem",
            rightSection: "View all",
            onTap: () {
              navCtrl.updateDashboardDynamicItem(
                HorizontalSlidingCardDataSource.HiddenGems,
              );
              navCtrl.updatePageListStack(
                IndividualDashboardViewAllDynamicScreen.routeName,
              );
            },
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.HiddenGems,
          ),
          // <<<< ========= HIDDEN GEM ENDS HERE ============ >>>>>>>

          ySpace(height: 120),
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
