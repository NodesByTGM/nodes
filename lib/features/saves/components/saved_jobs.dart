import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 27),
      itemCount: 5,
      itemBuilder: (c, i) {
        return const JobCard(isSaved: true);
      },
      separatorBuilder: (c, i) => ySpace(height: 14),
    );
  }
}
