
import 'package:nodes/features/dashboard/components/job_details_standardTalent.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class StandardTalentJobCard extends StatelessWidget {
  const StandardTalentJobCard({
    super.key,
    this.isFromBusiness = false,
    required this.job,
  });

  final bool isFromBusiness;
  final StandardTalentJobModel job;

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
                    "${job.applicants} applicants",
                    color: PRIMARY,
                    fontSize: 14,
                  ),
                ],
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

  saveUnsaveJob(BuildContext context, StandardTalentJobModel job) async {
    job.saved
        ? await context.read<DashboardController>().unSaveJob(context, job.id)
        : await context.read<DashboardController>().saveJob(context, job.id);
  }

  showJobDetailsBottomSheet(BuildContext context, StandardTalentJobModel job) {
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
              child: StandardTalentJobDetails(
                job: job,
                // This confusion is caused by the applicant's being hidden by the BE Elijah
              ),
            );
          },
        );
      },
    );
  }
}