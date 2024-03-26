import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/job_details.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_job_details_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    this.isFromBusiness = false,
  });

  final bool isFromBusiness;

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
                SvgPicture.asset(ImageUtils.saveJobIcon),
              ],
            ),
            ySpace(height: 16),
            labelText(
              "Job description/title",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            ySpace(height: 16),
            subtext(
              "Name of company",
              fontSize: 14,
            ),
            ySpace(height: 16),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.credit_card_sharp),
                subtext(
                  "\$10-1k/hr",
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
                      "\$20 hrs/wk",
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
                    "20 applicants",
                    color: PRIMARY,
                    fontSize: 14,
                  ),
                ],
                GestureDetector(
                  // onTap: () =>  showCreateSpaceBottomSheet(context),
                  onTap: () {
                    isFromBusiness
                        ? context.read<NavController>().updatePageListStack(
                              BusinessJobDetailsScreen.routeName,
                            )
                        : showCreateSpaceBottomSheet(context);
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

  showCreateSpaceBottomSheet(BuildContext context) {
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
                "Job title",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: const JobDetails(),
            );
          },
        );
      },
    );
  }
}
