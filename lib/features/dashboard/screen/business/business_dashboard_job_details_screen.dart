import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/job_analytics.dart';
import 'package:nodes/features/dashboard/components/job_applicants.dart';
import 'package:nodes/features/dashboard/components/job_details.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
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
  late JobModel job;
  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    job = dashCtrl.currentlyViewedBusinessJob;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
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
                    onTap: () {
                      //
                    },
                    loading: false,
                  ),
                  actionBtn(
                    icon: ImageUtils.shareOutlineIcon,
                    onTap: () {
                      //
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
        return JobDetails(
          job: job,
        );
      case 1:
        return JobApplicants(job: job);
      case 2:
        return JobAnalytics(job: job);
      default:
        return JobDetails(
          job: job,
        );
    }
  }

  void deleteJob() async {
    bool done = await dashCtrl.deleteSingleJob(context, job.id);
    if (done && mounted) {
      customNavigateBack(context);
    }
  }
}
