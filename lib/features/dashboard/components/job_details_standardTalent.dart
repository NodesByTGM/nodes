
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/dot_divider.dart';
import 'package:nodes/utilities/widgets/tag_chip.dart';

class StandardTalentJobDetails extends StatefulWidget {
  const StandardTalentJobDetails({
    super.key,
    required this.job,
  });

  final StandardTalentJobModel job;

  @override
  State<StandardTalentJobDetails> createState() => _StandardTalentJobDetailsState();
}

class _StandardTalentJobDetailsState extends State<StandardTalentJobDetails> {
  late StandardTalentJobModel job;
  late DashboardController dashCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    job = widget.job;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dashCtrl = context.watch<DashboardController>();
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 20),
      children: [
        ListTile(
          leading: Image.asset(
            ImageUtils.jobDpIcon,
            height: 44,
          ),
          title: labelText(
            "${job.business?.name}",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          subtitle: subtext(
            "Lagos, Nigeria",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        ySpace(height: 14),
        Row(
          children: [
            subtext(
              "Posted ${shortTime(job.createdAt ?? DateTime.now())}",
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            const CustomDot(),
            subtext(
              "${job.applicants} applicants",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: BLACK.withOpacity(0.7),
            ),
          ],
        ),
        ySpace(height: 27),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: WHITE,
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 16,
              ),
              xSpace(width: 5),
              subtext(
                // "20 hrs/wk",
                "${job.workRate}",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const CustomDot(),
              CustomTagChip(
                title: Constants.jobType[job.jobType as int],
              ),
            ],
          ),
        ),
        ySpace(height: 24),
          Row(
            children: [
              dashCtrl.isSavingUnsavedJobs
                  ? const Loader()
                  : GestureDetector(
                      onTap: () {
                        saveJob();
                      },
                      child: SvgPicture.asset(job.saved
                          ? ImageUtils.saveJobFilledIcon
                          : ImageUtils.saveJobIcon),
                    ),
              xSpace(width: 16),
              Expanded(
                child: SubmitBtn(
                  onPressed: job.applied
                      ? null
                      : () {
                          applyForJob();
                        },
                  title: btnTxt(
                    job.applied ? "Applied" : "Apply",
                    WHITE,
                  ),
                  loading: dashCtrl.isApplyingForJob,
                ),
              ),
            ],
          ),
          ySpace(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SvgPicture.asset(ImageUtils.briefcaseIcon),
                  labelText(
                    "1 - 3 years of experience",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              ySpace(height: 19),
              Wrap(
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SvgPicture.asset(ImageUtils.briefcaseIcon),
                  labelText(
                    "Skills",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              ySpace(height: 16),
              Wrap(
                children: [
                  ...List.generate(
                    (job.skills?.length ?? 0),
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 4,
                      ),
                      child: CustomTagChip(title: "${job.skills?[index]}"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        ySpace(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Job description",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 24),
              subtext(
                "${job.description}",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void saveJob() async {
    await dashCtrl.saveJob(context, job.id);
  }

  void applyForJob() async {
    await dashCtrl.applyForJob(context, job.id);
  }
}
