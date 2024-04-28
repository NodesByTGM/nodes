// ignore_for_file: file_names

import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/job_details_standardTalent.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class StandardTalentJobCard extends StatefulWidget {
  const StandardTalentJobCard({
    super.key,
    required this.job,
    required this.id,
  });

  final StandardTalentJobModel job;
  final String id;

  @override
  State<StandardTalentJobCard> createState() => _StandardTalentJobCardState();
}

class _StandardTalentJobCardState extends State<StandardTalentJobCard> {
  ValueNotifier<bool> isSavingJob = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    bool canApply = context.read<AuthController>().currentUser.type == 1 ||
        context.read<AuthController>().currentUser.type == 2;

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
                ValueListenableBuilder(
                  valueListenable: isSavingJob,
                  builder: (context, bool savingStatus, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // context.watch<DashboardController>().isSavingUnsavedJobs
                        savingStatus
                            ? const Padding(
                                padding: EdgeInsets.only(top: 10, right: 15),
                                child: SaveIconLoader(),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (canApply) {
                                    isSavingJob.value = true;
                                    await saveUnsaveJob(context, widget.job);
                                    isSavingJob.value = false;
                                  } else {
                                    showText(
                                      message:
                                          "Oops!! You have to upgrade to PRO to have this feature.",
                                    );
                                  }
                                },
                                child: SvgPicture.asset(widget.job.saved
                                    ? ImageUtils.saveJobFilledIcon
                                    : ImageUtils.saveJobIcon),
                              ),
                      ],
                    );
                  },
                ),
              ],
            ),
            ySpace(height: 16),
            labelText(
              capitalize("${widget.job.name}"),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            ySpace(height: 16),
            subtext(
              // "${job.business?.name}",
              capitalize("${widget.job.business?.name}"),
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
                  "${widget.job.payRate}",
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
                      "${widget.job.workRate}",
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
                  onTap: () => showJobDetailsBottomSheet(context, widget.job),
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

  @override
  void dispose() {
    isSavingJob.dispose();
    super.dispose();
  }
}
