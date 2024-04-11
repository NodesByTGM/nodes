import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/job_details.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_job_details_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

/**
 * 
 * 
 *  We will have two separate cards
 * 1. Individual and Talent job cards, where the save button for individuals will prompt them to upgrade
 * 2. Business job cards, which shows the applicants and details
 * 
 *  Same case with the job card details
 */

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    this.isFromBusiness = false,
    required this.job,
  });

  final bool isFromBusiness;
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: BORDER),
        color: WHITE,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ImageUtils.jobDpIcon,
                  height: 72,
                ),
                // SvgPicture.asset(isSaved
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    context.watch<DashboardController>().isSavingUnsavedJobs
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10, right: 15),
                            child: SaveIconLoader(),
                          )
                        : GestureDetector(
                            onTap: () {
                              saveUnsaveJob(context, job);
                            },
                            child: SvgPicture.asset(job.saved
                                ? ImageUtils.saveJobFilledIcon
                                : ImageUtils.saveJobIcon),
                          ),
                  ],
                ),
              ],
            ),
            ySpace(height: 16),
            labelText(
              capitalize("${job.name}"),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            ySpace(height: 16),
            subtext(
              "${job.business?.name}",
              fontSize: 14,
            ),
            ySpace(height: 16),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.credit_card_sharp),
                subtext(
                  // "\$10-1k/hr",
                  "${job.payRate}",
                  fontSize: 14,
                ),
              ],
            ),
            ySpace(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    subtext(
                      // "\$20 hrs/wk",
                      "${job.workRate}",
                      fontSize: 14,
                    ),
                  ],
                ),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                    ),
                    subtext(
                      "Lagos | Nigeria",
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
            ySpace(height: 16),
            Row(
              mainAxisAlignment: isFromBusiness
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (isFromBusiness) ...[
                  subtext(
                    "${job.applicants?.length} applicants",
                    color: PRIMARY,
                    fontSize: 14,
                  ),
                ],
                GestureDetector(
                  onTap: () {
                    if (isFromBusiness) {
                      context
                          .read<DashboardController>()
                          .setCurrentlyViewedJob(job);
                      context.read<NavController>().updatePageListStack(
                            BusinessJobDetailsScreen.routeName,
                          );
                    } else {
                      showJobDetailsBottomSheet(context, job);
                    }
                  },
                  child: labelText(
                    isFromBusiness ? "View details" : "View job",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: PRIMARY,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  saveUnsaveJob(BuildContext context, JobModel job) async {
    job.saved
        ? await context.read<DashboardController>().unSaveJob(context, job.id)
        : await context.read<DashboardController>().saveJob(context, job.id);
  }

  showJobDetailsBottomSheet(BuildContext context, JobModel job) {
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "${job.name}",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: JobDetails(
                job: job,
                isFromBusiness: false,
                // This confusion is caused by the applicant's being hidden by the BE Elijah
              ),
            );
          },
        );
      },
    );
  }
}

class SavedJobCard extends StatelessWidget {
  const SavedJobCard({
    super.key,
    required this.job,
  });

  final SavedJobModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: BORDER),
        color: WHITE,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ImageUtils.jobDpIcon,
                  height: 72,
                ),
                // SvgPicture.asset(isSaved
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    context.watch<DashboardController>().isSavingUnsavedJobs
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10, right: 15),
                            child: SaveIconLoader(),
                          )
                        : GestureDetector(
                            onTap: () {
                              saveUnsaveJob(context, job);
                            },
                            child: SvgPicture.asset(job.saved
                                ? ImageUtils.saveJobFilledIcon
                                : ImageUtils.saveJobIcon),
                          ),
                  ],
                ),
              ],
            ),
            ySpace(height: 16),
            labelText(
              capitalize("${job.name}"),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            ySpace(height: 16),
            subtext(
              "${job.business?.name}",
              fontSize: 14,
            ),
            ySpace(height: 16),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.credit_card_sharp),
                subtext(
                  // "\$10-1k/hr",
                  "${job.payRate}",
                  fontSize: 14,
                ),
              ],
            ),
            ySpace(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    subtext(
                      // "\$20 hrs/wk",
                      "${job.workRate}",
                      fontSize: 14,
                    ),
                  ],
                ),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                    ),
                    subtext(
                      "Lagos | Nigeria",
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
            ySpace(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => showJobDetailsBottomSheet(context, job),
                  child: labelText(
                    "View job",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: PRIMARY,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  saveUnsaveJob(BuildContext context, SavedJobModel job) async {
    job.saved
        ? await context.read<DashboardController>().unSaveJob(context, job.id)
        : await context.read<DashboardController>().saveJob(context, job.id);
  }

  showJobDetailsBottomSheet(BuildContext context, SavedJobModel job) {
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "${job.name}",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: SavedJobDetails(job: job),
            );
          },
        );
      },
    );
  }
}
