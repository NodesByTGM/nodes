import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/event_card.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({
    super.key,
    required this.events,
  });
  final List<EventModel> events;

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  late AuthController authCtrl;
  late UserModel user;
  // Will be using the event model for standard and talent
  late List<EventModel> events;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    events = widget.events;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
    return isObjectEmpty(events)
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
            itemCount: events.length,
            itemBuilder: (c, i) {
              return SizedBox(
                height: 280,
                child: EventCard(
                  event: events[i],
                ),
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 24),
          );
  }
}
