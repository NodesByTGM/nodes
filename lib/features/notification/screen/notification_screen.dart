import 'package:nodes/features/notification/components/all_notification.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const String routeName = "/notification_screen";

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AppWrapper(
        isCancel: false,
        appBarBottomBorder: false,
        leading: const SizedBox.shrink(),
        title: labelText("Notifications"),
        body: Column(
          children: [
            TabBar(
              labelColor: BLACK,
              indicatorColor: BLACK,
              unselectedLabelColor: GRAY,
              splashFactory: NoSplash.splashFactory,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              }),
              tabs: const [
                Tab(
                  text: "All (1)",
                ),
                Tab(
                  text: "Mentions (2)",
                ),
                Tab(
                  text: "Unread (2)",
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AllNotificationList(),
                  Icon(Icons.directions_transit, size: 350),
                  Icon(Icons.directions_car, size: 350),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        navigateBack(context);
                      },
                      child: labelText(
                        "Go Back",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  xSpace(width: 16),
                  Expanded(
                    flex: 2,
                    child: SubmitBtn(
                      onPressed: () {},
                      title: btnTxt(
                        "Mark all as read",
                        WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
