import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';
import 'package:nodes/features/dashboard/components/event_card_standardTalent.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/features/dashboard/components/job_card_standardTalent.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_view_all_dynamic_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/features/subscriptions/screen/proceed_with_payment_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
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
  late UserModel user;
  int currentEventIndex = 0;
  int currentTrendingIndex = 0;
  final eventsCardCtrl = PageController(viewportFraction: 1);
  final trendingCardCtrl = PageController(viewportFraction: 1);

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
    fetchTrending();
    fetchAllJobs();
    fetchAllEvents();
  }

  fetchAllJobs() {
    safeNavigate(() => dashCtrl.fetchAllJobs(context));
  }

  fetchAllEvents() {
    safeNavigate(() => dashCtrl.fetchAllEvents(context));
  }

  fetchTrending() {
    safeNavigate(() => dashCtrl.fetchTrending(context));
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
            "Checkout the blah blah blah blah blah blah",
            fontSize: 14,
          ),
          customDivider(height: 40),
          ySpace(height: 20),
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
                List<StandardTalentEventModel> eventsList = dCtrl.eventsList;
                return SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: eventsList.length,
                    controller: eventsCardCtrl,
                    onPageChanged: (val) {
                      currentEventIndex = val;
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
          ySpace(height: 20),
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
                        isActive: currentEventIndex == index,
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
                        currentIndex: currentEventIndex,
                        ctrl: eventsCardCtrl,
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
                        currentIndex: currentEventIndex,
                        ctrl: eventsCardCtrl,
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
          if (user.type == 1) ...[
            // Meaning the User is Talent
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...List.generate(dashCtrl.jobsList.length, (index) {
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
                        totoalLength: dashCtrl.jobsList.length,
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
                        totoalLength: dashCtrl.jobsList.length,
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
}