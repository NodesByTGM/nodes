import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/job_card_business.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class JobsTab extends StatefulWidget {
  const JobsTab({
    super.key,
    required this.jobs,
  });
  final List<BusinessJobModel> jobs;

  @override
  State<JobsTab> createState() => _JobsTabState();
}

class _JobsTabState extends State<JobsTab> {
  late AuthController authCtrl;
  late UserModel user;
  // Will be using the job model for standard and talent
  late List<BusinessJobModel> jobs; 

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    jobs = widget.jobs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return isObjectEmpty(jobs)
        ? Container(
            color: WHITE,
            // height: 200,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ySpace(height: 20),
                    labelText(
                      "Hi ${user.name?.split(" ").first}!",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 20),
                    subtext(
                      "Nothing to see here yet.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    ySpace(height: 40),
                    SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                  ],
                ),
              ),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: jobs.length,
            itemBuilder: (c, i) {
              return BusinessJobCard(
                job: jobs[i],
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 24),
          );
  }
}
