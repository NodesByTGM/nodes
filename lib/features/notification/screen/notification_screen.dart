import 'package:nodes/features/notification/components/all_notification.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

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
                  text: "All (*)",
                ),
                Tab(
                  text: "Mentions (*)",
                ),
                Tab(
                  text: "Unread (*)",
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AllNotificationList(type: NotificationType.All),
                  AllNotificationList(type: NotificationType.Mentioned),
                  AllNotificationList(type: NotificationType.Unread),
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
                      // Se to Null if nothing happens...
                      onPressed: null,
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
