import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/screen/business/business_dashboard_job_details_screen.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class BusinessJobCard extends StatelessWidget {
  const BusinessJobCard({
    super.key,
    required this.job,
  });

  final BusinessJobModel job;

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
                // Delete Icon maybe
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
              /** 
               * George, work on this...
               */
              // "${job.business?.name ?? 'Business Name'}",
              capitalize("${job.business?.name}"),
              fontSize: 14,
            ),
            ySpace(height: 16),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.credit_card_sharp),
                subtext(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subtext(
                  "${job.applicants?.length} applicants",
                  color: PRIMARY,
                  fontSize: 14,
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<DashboardController>()
                        .setCurrentlyViewedJob(job);
                    context.read<NavController>().updatePageListStack(
                          BusinessJobDetailsScreen.routeName,
                        );
                  },
                  child: labelText(
                    "View details",
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
}
