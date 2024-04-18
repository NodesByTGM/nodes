import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class AllNotificationList extends StatefulWidget {
  const AllNotificationList({super.key});

  @override
  State<AllNotificationList> createState() => _AllNotificationListState();
}

class _AllNotificationListState extends State<AllNotificationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20),
      itemCount: 20,
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
  }
}
