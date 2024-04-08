import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/create_event.dart';
import 'package:nodes/features/dashboard/components/create_job_post.dart';
import 'package:nodes/features/dashboard/components/dot_indicator.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_events.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_view_all_jobs.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
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
  int jobLength = 5;
  int trendingLength = 5;
  int currentJobIndex = 0;
  int currentTrendingIndex = 0;
  final trendingCtrl = PageController(viewportFraction: 1);
  final jobsCardCtrl = PageController(viewportFraction: 1);

  // dummy data
  bool hasJobs = true;
  bool hasEvents = true;

  @override
  void initState() {
    navCtrl = locator.get<NavController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 1 > 2
        ? ListView(
            shrinkWrap: true,
            children: [
              ySpace(height: 80),
              labelText(
                "Hi Aderinsola!",
                fontSize: 24,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              ySpace(height: 20),
              subtext(
                "Just getting started?\nWould you like to create a business account?",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              ySpace(height: 40),
              SvgPicture.asset(ImageUtils.spaceEmptyIcon),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SubmitBtn(
                  onPressed: () {},
                  title: btnTxt(
                    "Add Business account",
                    WHITE,
                  ),
                ),
              ),
            ],
          )
        : ListView(
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
                      title: "Complete your\nbusiness profile",
                      btnTitle: "Complete Profile",
                      icon: ImageUtils.headIcon,
                      onTap: () {},
                    ),
                    ySpace(height: 24),
                    QuickSetupCard(
                      title: "Create a job\npost",
                      btnTitle: "Discover",
                      icon: ImageUtils.thrunkIcon,
                      onTap: () => showCreateJobBottomSheet(0),
                    ),
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
                          navCtrl.updatePageListStack(
                            BusinessJobCenterScreen.routeName,
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
              if (!hasJobs) ...[
                EmptyStateWithTextBtn(
                  title: "Hi Aderinsola!",
                  content:
                      "Nothing to see here yet,\nCreate a job post to get started.",
                  onTap: () => showCreateJobBottomSheet(0),
                  btnText: "Create job post",
                ),
              ],
              if (hasJobs) ...[
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
                      return const JobCard(
                        job: JobModel(),
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
                      navCtrl.updatePageListStack(
                        BusinessEventCenterScreen.routeName,
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
              ySpace(height: 24),
              if (!hasEvents) ...[
                EmptyStateWithTextBtn(
                  title: "Hi Aderinsola!",
                  content:
                      "Nothing to see here yet,\nCreate events to get started.",
                  onTap: () => showCreateJobBottomSheet(1),
                  btnText: "Create event",
                ),
              ],
              if (hasEvents) ...[
                SizedBox(
                  // height: 368,
                  height: 250,
                  child: PageView.builder(
                    itemCount: trendingLength,
                    controller: trendingCtrl,
                    onPageChanged: (val) {
                      currentTrendingIndex = val;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return const EventCard(
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
