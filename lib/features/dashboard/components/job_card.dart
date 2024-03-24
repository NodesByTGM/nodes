import 'package:nodes/features/dashboard/components/job_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: BORDER),
        // color: RED,
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
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => showCreateSpaceBottomSheet(context),
                child: labelText(
                  "View job",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: PRIMARY,
                ),
              ),
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
