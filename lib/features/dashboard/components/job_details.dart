import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/dot_divider.dart';
import 'package:nodes/utilities/widgets/tag_chip.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({
    super.key,
    this.isFromBusiness = false,
  });

  final bool isFromBusiness;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (!widget.isFromBusiness) ...[
          ListTile(
            leading: Image.asset(
              ImageUtils.jobDpIcon,
              height: 44,
            ),
            title: labelText(
              "Name of company",
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
                "Posted ${shortTime(DateTime.now())}",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const CustomDot(),
              subtext(
                "25 applicants",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: BLACK.withOpacity(0.7),
              ),
            ],
          ),
        ],
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
                "20 hrs/wk",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const CustomDot(),
              CustomTagChip(title: "Remote"),
              const CustomDot(),
              CustomTagChip(title: "Full-time"),
            ],
          ),
        ),
        ySpace(height: 24),
        if (!widget.isFromBusiness) ...[
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showSuccess(message: "Job Saved");
                },
                child: SvgPicture.asset(ImageUtils.saveJobIcon),
              ),
              xSpace(width: 16),
              Expanded(
                child: SubmitBtn(
                  onPressed: () {
                    showSuccess(message: "Applied");
                  },
                  title: btnTxt(
                    "Apply",
                    WHITE,
                  ),
                ),
              ),
            ],
          ),
          ySpace(height: 24),
        ],
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
                    7,
                    (index) => const Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                        bottom: 4,
                      ),
                      child: CustomTagChip(title: "Remote"),
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
                "Lorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.\n\n\nLorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.\n\nLorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.\n\n\nLorem ipsum dolor sit amet consectetur. Tincidunt sit mattis pellentesque imperdiet etiam curabitur. Sit vitae vel et justo egestas sit enim turpis. Blandit in ullamcorper non vel volutpat. Quam condimentum faucibus auctor mattis sed consectetur viverra.",
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
