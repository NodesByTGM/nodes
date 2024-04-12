import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/dashboard/components/event_card_standardTalent.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class SavedEvents extends StatefulWidget {
  const SavedEvents({super.key});

  @override
  State<SavedEvents> createState() => _SavedEventsState();
}

class _SavedEventsState extends State<SavedEvents> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (contex, dashCtrl, _) {
        bool isLoading = dashCtrl.isFetchingAllSavedEvents;
        bool hasData = isObjectEmpty(dashCtrl.savedEvents);
        if (isLoading || isObjectEmpty(dashCtrl.savedEvents)) {
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
          List<StandardTalentEventModel> savedEvents = dashCtrl.savedEvents;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 27),
            itemCount: savedEvents.length,
            itemBuilder: (c, i) {
              return SizedBox(
                height: 300,
                child: StandardTalentEventCard(
                  hasDelete: false,
                  hasSave: true,
                  event: savedEvents[i],
                ),
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 14),
          );
        }
      },
    );
  }

  void _reloadData(BuildContext context) {
    safeNavigate(
        () => locator.get<DashboardController>().fetchAllSavedEvents(context));
  }
}
