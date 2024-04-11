import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class JobApplicants extends StatelessWidget {
  const JobApplicants({super.key, required this.job});

  final BusinessJobModel job;

  @override
  Widget build(BuildContext context) {
    return isObjectEmpty(job.applicants)
        ? SizedBox(
            height: 200,
            child: Center(
              child: labelText("No Applicants yet"),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: job.applicants?.length ?? 0,
            padding: const EdgeInsets.only(top: 32),
            itemBuilder: (c, i) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: WHITE,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 0.7,
                    color: BORDER,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageUtils.jobDpIcon,
                      height: 40,
                    ),
                    ySpace(height: 10),
                    labelText(
                      "Name of applicant",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 10),
                    subtext(
                      "janedoe@gmail.com",
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: labelText(
                          "View profile",
                          color: PRIMARY,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 16),
          );
  }
}
