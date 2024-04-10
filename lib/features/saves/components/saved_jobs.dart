import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/components/job_card.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class SavedJobs extends StatelessWidget {
  const SavedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (contex, dashCtrl, _) {
        bool isLoading = dashCtrl.isFetchingAllSavedJobs;
        bool hasData = isObjectEmpty(dashCtrl.savedJobsList);
        if (isLoading || isObjectEmpty(dashCtrl.savedJobsList)) {
          return DataReload(
            maxHeight: screenHeight(context) * .19,
            isLoading: isLoading,
            loader: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerLoader(
                scrollDirection: Axis.vertical,
                width: screenWidth(context),
                marginBottom: 10,
              ),
            ), // Pass the shimmer here...
            onTap: () => _reloadData(context),
            isEmpty: hasData,
          );
        } else {
          List<SavedJobModel> savedJobs = dashCtrl.savedJobsList;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 27),
            itemCount: savedJobs.length,
            itemBuilder: (c, i) {
              return SavedJobCard(
                job: savedJobs[i],
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 14),
          );
        }
      },
    );
  }

  void _reloadData(BuildContext context) {
    safeNavigate(() => locator.get<DashboardController>().fetchAllSavedJobs(context));
  }
}
