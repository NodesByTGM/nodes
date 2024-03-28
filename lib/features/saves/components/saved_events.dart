import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class SavedEvents extends StatefulWidget {
  const SavedEvents({super.key});

  @override
  State<SavedEvents> createState() => _SavedEventsState();
}

class _SavedEventsState extends State<SavedEvents> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 27),
      itemCount: 5,
      itemBuilder: (c, i) {
        return const EventCard(
          hasDelete: false,
          hasSave: true,
          isSaved: true,
        );
      },
      separatorBuilder: (c, i) => ySpace(height: 14),
    );
  }
}
