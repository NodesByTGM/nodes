import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/business_verification_form.dart';
import 'package:nodes/features/dashboard/components/create_event.dart';
import 'package:nodes/features/dashboard/components/create_job_post.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/components/job_card_business.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_created_events.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_created_jobs.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/screens/business/business_profile_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/card_dot_generator.dart';
import 'package:nodes/utilities/widgets/quick_setup_card.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});
  static const String routeName = "/business_dashboard_screen";

  @override
  State<BusinessDashboardScreen> createState() =>
      _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen> {
  late NavController navCtrl;
  late AuthController authCtrl;
  late DashboardController dashCtrl;
  late UserModel user;
  late BusinessAccountModel businessAccount;
  int currentJobIndex = 0;
  int currentTrendingIndex = 0;
  final trendingCtrl = PageController(viewportFraction: 1);
  final jobsCardCtrl = PageController(viewportFraction: 1);

  @override
  void initState() {
    navCtrl = locator.get<NavController>();
    authCtrl = locator.get<AuthController>();
    dashCtrl = locator.get<DashboardController>();
    user = authCtrl.currentUser;
    businessAccount = user.business ?? const BusinessAccountModel();
    super.initState();
    fetchMyCreatedEventAndJobsTrending();
    if (mounted) {
      showBusinessAccountVerificationModal();
    }
  }

  fetchMyCreatedEventAndJobsTrending() {
    // Should be fetching all my created jobs
    safeNavigate(() => dashCtrl.fetchAllMyCreatedJobs(context));
    // Should be fetching all my created events
    safeNavigate(() => dashCtrl.fetchAllAllMyCreatedEvents(context));
    safeNavigate(() => dashCtrl.fetchTrending(context));
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    dashCtrl = context.watch<DashboardController>();
    user = authCtrl.currentUser;
    businessAccount = user.business ?? const BusinessAccountModel();
    return ListView(
      children: [
        ySpace(height: 40),
        labelText(
          "Hi  ${businessAccount.name?.split(' ').first}!, Nice to have you here.",
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
            color: LIGHT_SECONDARY,
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
              if (!isBusinessProfileComplete(businessAccount)) ...[
                QuickSetupCard(
                  title: "Complete your\nbusiness profile",
                  btnTitle: "Complete Profile",
                  icon: ImageUtils.headIcon,
                  borderColor: LIGHT_SECONDARY,
                  onTap: () {
                    context.read<NavController>().updatePageListStack(
                          BusinessProfileScreen.routeName,
                        );
                  },
                ),
                ySpace(height: 24),
              ],
              QuickSetupCard(
                  title: "Create a job\npost",
                  btnTitle: "Create Job",
                  icon: ImageUtils.thrunkIcon,
                  borderColor: LIGHT_SECONDARY,
                  onTap: () {
                    BusinessAccountModel business =
                        user.business ?? const BusinessAccountModel();
                    if (isBusinessProfileComplete(business) &&
                        isBusinessVerified(business)) {
                      // Profile must be complete and business account verified
                      showCreateJobBottomSheet(0);
                    } else if (isBusinessProfileComplete(business) &&
                        !isBusinessVerified(business)) {
                      // Profile is complete but business account is not verified
                      cantCreateMsg(i: 1);
                    } else {
                      // Profile is not complete
                      cantCreateMsg();
                    }
                    // if (isBusinessProfileComplete(business)) {
                    //   showCreateJobBottomSheet(0);
                    // } else if (isBusinessVerified(business)) {
                    //   cantCreateMsg(i: 1);
                    // } else {
                    //   cantCreateMsg();
                    // }
                  }),
            ],
          ),
        ),
        ySpace(height: 72),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText(
              "Jobs by you",
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
                    if (isObjectEmpty(dashCtrl.createdJobList)) {
                      showText(
                          message:
                              "Oops!! you currently don't have any job created yet.");
                    } else {
                      navCtrl.updatePageListStack(
                        BusinessCreatedJobCenterScreen.routeName,
                      );
                    }
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
        if (isObjectEmpty(dashCtrl.createdJobList)) ...[
          EmptyStateWithTextBtn(
            title: "Hi ${user.name?.split(' ').first}!",
            content:
                "Nothing to see here yet,\nCreate a Job post to get started.",
            onTap: () {
              BusinessAccountModel business =
                  user.business ?? const BusinessAccountModel();
              if (isBusinessProfileComplete(business) &&
                  isBusinessVerified(business)) {
                showCreateJobBottomSheet(0);
              } else if (isBusinessProfileComplete(business) &&
                  !isBusinessVerified(business)) {
                cantCreateMsg(i: 1);
              } else {
                cantCreateMsg();
              }

              // if (isBusinessProfileComplete(business)) {
              //   showCreateJobBottomSheet(0);
              // }
              // if (isBusinessVerified(business)) {
              //   cantCreateMsg(i: 1);
              // } else {
              //   cantCreateMsg();
              // }
            },
            btnText: "Create job post",
          ),
        ],
        if (!isObjectEmpty(dashCtrl.createdJobList)) ...[
          SizedBox(
            height: 320,
            child: PageView.builder(
              itemCount: dashCtrl.createdJobList.length > 5
                  ? 5
                  : dashCtrl.createdJobList.length,
              controller: jobsCardCtrl,
              onPageChanged: (val) {
                currentJobIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return BusinessJobCard(
                  // Look into this properly
                  job: dashCtrl.createdJobList[index],
                );
              },
            ),
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardDotGenerator(
                length: dashCtrl.createdJobList.length > 5
                    ? 5
                    : dashCtrl.createdJobList.length,
                currentIndex: currentJobIndex,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: dashCtrl.createdJobList.length > 5
                            ? 5
                            : dashCtrl.createdJobList.length,
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
                        totoalLength: dashCtrl.createdJobList.length > 5
                            ? 5
                            : dashCtrl.createdJobList.length,
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
        ],
        labelText(
          "Exclusive events",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 8),
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
                if (isObjectEmpty(dashCtrl.myCreatedEventsList)) {
                  showText(
                      message:
                          "Oops!! you currently don't have any Event created yet.");
                } else {
                  navCtrl.updatePageListStack(
                    BusinessCreatedEventCenterScreen.routeName,
                  );
                }
              },
              child: subtext(
                "See more",
                fontSize: 14,
                color: PRIMARY,
              ),
            ),
          ],
        ),
        ySpace(height: 24),
        if (isObjectEmpty(dashCtrl.myCreatedEventsList)) ...[
          EmptyStateWithTextBtn(
            title: "Hi ${user.name?.split(' ').first}!",
            content: "Nothing to see here yet,\nCreate events to get started.",
            onTap: () {
              BusinessAccountModel business =
                  user.business ?? const BusinessAccountModel();

              if (isBusinessProfileComplete(business) &&
                  isBusinessVerified(business)) {
                showCreateJobBottomSheet(1);
              } else if (isBusinessProfileComplete(business) &&
                  !isBusinessVerified(business)) {
                cantCreateMsg(i: 1);
              } else {
                cantCreateMsg();
              }
              // if (isBusinessProfileComplete(business)) {
              //   showCreateJobBottomSheet(1);
              // }
              // if (isBusinessVerified(business)) {
              //   cantCreateMsg(i: 1);
              // } else {
              //   cantCreateMsg();
              // }
            },
            btnText: "Create event",
          ),
        ],
        if (!isObjectEmpty(dashCtrl.myCreatedEventsList)) ...[
          SizedBox(
            height: 280,
            child: PageView.builder(
              itemCount: dashCtrl.myCreatedEventsList.length > 5
                  ? 5
                  : dashCtrl.myCreatedEventsList.length,
              controller: trendingCtrl,
              onPageChanged: (val) {
                currentTrendingIndex = val;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return EventCard(
                  event: dashCtrl.myCreatedEventsList[index],
                );
              },
            ),
          ),
          ySpace(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardDotGenerator(
                length: dashCtrl.myCreatedEventsList.length > 5
                    ? 5
                    : dashCtrl.myCreatedEventsList.length,
                currentIndex: currentTrendingIndex,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      customAnimatePageView(
                        isInc: false,
                        totoalLength: dashCtrl.myCreatedEventsList.length > 5
                            ? 5
                            : dashCtrl.myCreatedEventsList.length,
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
                        totoalLength: dashCtrl.myCreatedEventsList.length > 5
                            ? 5
                            : dashCtrl.myCreatedEventsList.length,
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
      ],
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

  showCreateJobBottomSheet(int index) {
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
        return BottomSheetWrapper(
          closeOnTap: true,
          title: labelText(
            index == 0 ? "Create a Job Post" : "Create an event",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          child: index == 0 ? const CreateJobPost() : const CreateEvent(),
        );
      },
    );
  }

  void cantCreateMsg({int i = 0}) {
    showText(
        message: i == 0
            ? Constants.updateYourProfileToProceed
            : Constants.accountNotVerified);
  }

  showBusinessAccountVerificationModal() async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (!isBusinessProfileComplete(businessAccount)) {
        showSimpleDialog(
          context: context,
          backgroundColor: Colors.white,
          dismissable: false,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 0),
          child: const BusinessVerificationForm(),
        );
      }
    });
  }
}

class EmptyStateWithTextBtn extends StatelessWidget {
  const EmptyStateWithTextBtn({
    super.key,
    required this.title,
    required this.content,
    required this.btnText,
    required this.onTap,
  });

  final String title;
  final String content;
  final String btnText;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ySpace(height: 20),
        labelText(
          title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 8),
        subtext(
          content,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
        ySpace(height: 16),
        GestureDetector(
          onTap: onTap,
          child: labelText(
            btnText,
            color: PRIMARY,
          ),
        ),
        SvgPicture.asset(
          ImageUtils.spaceEmptyIcon,
        ),
      ],
    );
  }
}
