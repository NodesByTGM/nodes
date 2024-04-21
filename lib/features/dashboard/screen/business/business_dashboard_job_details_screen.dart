// ignore_for_file: use_build_context_synchronously

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/components/create_job_post.dart';
import 'package:nodes/features/dashboard/components/job_analytics.dart';
import 'package:nodes/features/dashboard/components/job_applicants.dart';
import 'package:nodes/features/dashboard/components/job_details_business.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BusinessJobDetailsScreen extends StatefulWidget {
  const BusinessJobDetailsScreen({super.key});

  static const String routeName = "/business_dashboard_job_details_screen";

  @override
  State<BusinessJobDetailsScreen> createState() =>
      _BusinessJobDetailsScreenState();
}

class _BusinessJobDetailsScreenState extends State<BusinessJobDetailsScreen> {
  int currentIndex = 0;

  late DashboardController dashCtrl;
  late BusinessJobModel job;
  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    job = dashCtrl.currentlyViewedBusinessJob;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    job = dashCtrl.currentlyViewedBusinessJob;
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 32, bottom: 60),
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  labelText(
                    capitalize("${job.name}"),
                    maxLine: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  actionBtn(
                    icon: ImageUtils.trashOutlineIcon,
                    onTap: deleteJob,
                    loading: dashCtrl.isDeletingJob,
                  ),
                  actionBtn(
                    icon: ImageUtils.editPencileOutlineIcon,
                    onTap: showCreateJobBottomSheet,
                    loading: context.watch<DashboardController>().isUpdatingJob,
                  ),
                  actionBtn(
                    icon: ImageUtils.shareOutlineIcon,
                    onTap: () async {
                      await shareDoc(
                        context,
                        url: "$nodeWebsite/${job.name}",
                      );
                    },
                    loading: false,
                  ),
                ],
              ),
            ),
            ySpace(height: 32),
            StickyHeaderBuilder(
              builder: (context, stuckAmount) {
                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  // color: stuckAmount <= -0.54 ? WHITE : null,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: BORDER),
                    ),
                    color: WHITE,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tabHeader(
                        isActive: currentIndex == 0,
                        title: "Details",
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                      ),
                      tabHeader(
                        isActive: currentIndex == 1,
                        title: "Applicants (${job.applicants?.length})",
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                      ),
                      tabHeader(
                        isActive: currentIndex == 2,
                        title: "Analytics",
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
              content: Container(
                color: PROFILEBG,
                padding: screenPadding,
                margin: const EdgeInsets.only(bottom: 60),
                child: getTabBody(),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: screenWidth(context),
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: WHITE,
              border: Border(
                top: BorderSide(width: 0.7, color: BORDER),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                customNavigateBack(context);
              },
              child: labelText(
                "Go Back",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  getTabBody() {
    switch (currentIndex) {
      case 0:
        return BusinessJobDetails(
          job: job,
        );
      case 1:
        return JobApplicants(job: job);
      case 2:
        return JobAnalytics(job: job);
      default:
        return BusinessJobDetails(
          job: job,
        );
    }
  }

  void deleteJob() async {
    final result = await showAlertDialog(
      context,
      body: subtext(
        "You are about to permanently  delete `${job.name}` Do you want to proceed?",
        fontSize: 13,
      ),
      title: "Delete this job post",
      cancelTitle: "No, Cancel",
      okTitle: "Yes, Delete",
      okColor: RED,
      cancelColor: GRAY,
    );
    if (DialogAction.yes == result) {
      // make the api request, delete account, call the logout function, to send them to the auth screen...
      bool done = await dashCtrl.deleteSingleJob(context, job.id);
      if (done && mounted) {
        customNavigateBack(context);
      }
    }
  }

  showCreateJobBottomSheet() {
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
            "Edit Job Post",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          child: CreateJobPost(
            job: job,
          ),
        );
      },
    );
  }
}
