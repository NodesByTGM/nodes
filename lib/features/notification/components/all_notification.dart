import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/model/notification_model.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';

class AllNotificationList extends StatefulWidget {
  const AllNotificationList({
    super.key,
    required this.type,
  });

  final NotificationType type;

  @override
  State<AllNotificationList> createState() => _AllNotificationListState();
}

class _AllNotificationListState extends State<AllNotificationList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthController, DashboardController>(
      builder: (context, aCtrl, dashCtrl, _) {
        Widget emptyMsg() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  labelText(
                    "Hi there, ${aCtrl.currentUser.name?.split(" ").first}",
                  ),
                  ySpace(height: 10),
                  subtext("Nothing to see here yet"),
                  ySpace(height: 10),
                  SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                ],
              ),
            );
        if (dashCtrl.isFetchingNotifications) {
          return Center(
            child: labelText("Fetching notifications..."),
          );
        }
        List<NotificationModel> notificationList = dashCtrl.notificationList;
        List<NotificationModel> mentionList = dashCtrl.notificationList;
        List<NotificationModel> unreadList = dashCtrl.notificationList;

        // Check the type, and also if they have they ain't got the data, then display error
        if ((widget.type == NotificationType.All) &&
            isObjectEmpty(notificationList)) {
          return emptyMsg();
        }
        if ((widget.type == NotificationType.Mentioned) &&
            isObjectEmpty(mentionList)) {
          return emptyMsg();
        }
        if ((widget.type == NotificationType.Unread) &&
            isObjectEmpty(unreadList)) {
          return emptyMsg();
        }
        // If all goes well, get the Final List to be displayed.
        List<NotificationModel> currentlyDisplayedList = [];
        switch (widget.type) {
          case NotificationType.All:
            currentlyDisplayedList = notificationList;
            break;
          case NotificationType.Mentioned:
            currentlyDisplayedList = mentionList;
            break;
          case NotificationType.Unread:
            currentlyDisplayedList = unreadList;
            break;
          default:
            currentlyDisplayedList = notificationList;
        }
        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 20),
          itemCount: currentlyDisplayedList.length,
          itemBuilder: (c, i) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              visualDensity: VisualDensity.compact,
              leading: CircleAvatar(
                backgroundColor: BORDER,
                child: labelText(
                  "AB",
                  color: BLACK.withOpacity(0.6),
                ),
              ),
              title: Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  subtext(
                    "Ashwin Bose",
                    fontWeight: FontWeight.w600,
                  ),
                  subtext("just gave your comment on"),
                ],
              ),
              subtitle: subtext("{insert name of article/post}"),
              trailing: Column(
                children: [
                  subtext("2m"),
                  PopupMenuButton<String>(
                    onSelected: (value) {},
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'Most recent',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              subtext("Most recent"),
                            ],
                          ),
                        )
                      ];
                    },
                    offset: const Offset(0, 40),
                    color: WHITE,
                    elevation: 2,
                    child: Icon(
                      MdiIcons.dotsHorizontal,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (c, i) => customDivider(),
        );
      },
    );
  }
}
