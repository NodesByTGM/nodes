import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/models/community_post_model.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/features/dashboard/components/job_card_standardTalent.dart';
import 'package:nodes/features/dashboard/components/leave_a_rating.dart';
import 'package:nodes/features/dashboard/components/top_movies_card_template.dart';
import 'package:nodes/features/dashboard/components/trending_news_card.dart';
import 'package:nodes/features/dashboard/model/movie_show_model.dart';
import 'package:nodes/features/dashboard/model/trending_model.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/features/subscriptions/screen/proceed_with_payment_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/card_dot_generator.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class TrendingDashboardScreen extends StatefulWidget {
  const TrendingDashboardScreen({super.key});
  static const String routeName = "/trending_dashboard_screen";

  @override
  State<TrendingDashboardScreen> createState() =>
      _TrendingDashboardScreenState();
}

class _TrendingDashboardScreenState extends State<TrendingDashboardScreen> {
  late NavController navCtrl;
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late ComController cCtrl;
  late UserModel user;
  int currentTrendingNewsIndex = 0;
  int currentTrendingIndex = 0;
  int currentPostIndex = 0;
  final trendingCardCtrl = PageController(viewportFraction: 1);
  final trendingNewsCardCtrl = PageController(viewportFraction: 1);
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
    fetchAllJobs();
    fetchAllPosts();
    fetchTrendingNews();
    fetchMoviesShows();
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

  fetchMoviesShows() {
    safeNavigate(() => dashCtrl.fetchMovieShows(context));
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    dashCtrl = context.watch<DashboardController>();
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
          labelText(
            "Trending News",
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
                    // itemCount: trendingNewsList.length,
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
          ySpace(height: 40),
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
          // FutureBuilder(
          //   future: dashCtrl.fetchMovieShows(context),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const ShimmerLoader();
          //     } else if (snapshot.hasError) {
          //       // Use a proper error widget with a Reload feature...
          //       return Container(
          //         margin: const EdgeInsets.only(right: 5),
          //         width: screenWidth(context),
          //         height: 200,
          //         decoration: const BoxDecoration(
          //           color: BORDER,
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(5),
          //           ),
          //         ),
          //         child: Center(
          //           child: labelText("Oops!!!! Error"),
          //         ),
          //       );
          //     } else if (snapshot.hasData &&
          //         snapshot.connectionState == ConnectionState.done) {
          //       return SizedBox(
          //         // height: 240,
          //         height: 240,
          //         child: SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Row(
          //             children: List.generate(
          //               snapshot.data!.length,
          //               (index) {
          //                 // Depending on the datasource, the corresponding cards will be used...
          //                 return TopMovieCardTemplate(
          //                   imgUrl:
          //                       "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
          //                   title: "Lorem ipsum dolor sit amet, con...",
          //                   onTap: () {},
          //                   ratingTap: () {
          //                     showRatingBottomSheet(
          //                         // passin the item details, likes of IDs, etc...
          //                         );
          //                   },
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       );
          //     }
          //     return const CircularProgressIndicator.adaptive();
          //   },
          // ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.TopMovies,
          ),
          ySpace(height: 40),
          if (user.type == 1) ...[
            // <<<<=============================== Meaning the User is Talent  =====================>>>>
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
                          onPressed: () {
                            // Set to Business Monthly sub
                            authCtrl.setSubUpgrade(
                              const SubscriptionUpgrade(
                                type: KeyString.bus,
                                amount: businessMonthlyAmt,
                                period: KeyString.monthly,
                                features: Constants.businessFeatures,
                                isSubscribed: false,
                              ),
                            );
                            context.read<NavController>().updatePageListStack(
                                  ProceedWithPayment.routeName,
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
            ySpace(height: 40),
          ],
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
                    itemCount: jobsList.length,
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
          ySpace(height: 40),
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
                      // navCtrl.updateDashboardDynamicItem(
                      //   HorizontalSlidingCardDataSource.TopMovies,
                      // );
                      // navCtrl.updatePageListStack(
                      //   IndividualDashboardViewAllDynamicScreen.routeName,
                      // );
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
          ySpace(height: 40),
          Subsection(
            leftSection: "Previously on Nodes",
            rightSection: "View all",
            onTap: () {},
          ),
          const HorizontalSlidingCards(
            dataSource: HorizontalSlidingCardDataSource.Birthdays,
          ),
          ySpace(height: 40),
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
                      "Join the conversation and connect with your tribe",
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

  // showRatingBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(30.0),
  //       ),
  //     ),
  //     backgroundColor: WHITE,
  //     elevation: 0.0,
  //     builder: (context) {
  //       return BottomSheetWrapper(
  //         closeOnTap: true,
  //         title: labelText(
  //           "Leave a rating",
  //           fontSize: 18,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         child: const LeaveARating(),
  //       );
  //     },
  //   );
  // }
}
