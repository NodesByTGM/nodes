import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/dot_divider.dart';
import 'package:nodes/utilities/widgets/tag_chip.dart';

class BusinessJobDetails extends StatefulWidget {
  const BusinessJobDetails({
    super.key,
    required this.job,
  });

  final BusinessJobModel job;

  @override
  State<BusinessJobDetails> createState() => _BusinessJobDetailsState();
}

class _BusinessJobDetailsState extends State<BusinessJobDetails> {
  late BusinessJobModel job;
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
    job = dashCtrl.currentlyViewedBusinessJob;
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
            /**
             * 
            //  Work on this George
             */
            // "${job.business?.name ?? "Business name"}",
            capitalize("${job.business?.name}"),
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
              "${job.applicants?.length} applicants",
              // "0 applicants",
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
                "${job.workRate}",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const CustomDot(),
              CustomTagChip(
                /**
             * 
            //  Work on this George
             */
                title: Constants.jobType[job.jobType],
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
}
