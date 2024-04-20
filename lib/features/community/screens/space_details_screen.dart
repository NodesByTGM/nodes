import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/components/space_about_tab.dart';
import 'package:nodes/features/community/components/space_discussion_tab.dart';
import 'package:nodes/features/community/components/space_members_tab.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class SpaceDetailsScreen extends StatefulWidget {
  const SpaceDetailsScreen({
    super.key,
    this.isCreateSpace = false,
  });
  static const String routeName = "/space_details_screen";

  final bool isCreateSpace;

  @override
  State<SpaceDetailsScreen> createState() => _SpaceDetailsScreenState();
}

class _SpaceDetailsScreenState extends State<SpaceDetailsScreen> {
  int currentTabIndex = 0;
  late ComController comCtrl;

  @override
  Widget build(BuildContext context) {
    comCtrl = context.watch<ComController>();
    return ListView(
      shrinkWrap: true,
      children: [
        ySpace(height: 40),
        GestureDetector(
          onTap: () {
            customNavigateBack(context);
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.keyboard_arrow_left,
                color: BORDER,
              ),
              subtext(
                "Go Back",
                fontSize: 12,
              ),
            ],
          ),
        ),
        ySpace(height: 30),
        CommunitySpaceCardTemplate(
          imgUrl:
              "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
          title: "Lorem ipsum dolor sit amet, con...",
          height: 300,
          width: screenWidth(context),
          marginRight: 0,
          onTapTitle: widget.isCreateSpace ? "Share space" : "Invite a friend",
          onTap: () {},
          popupMenu: !comCtrl.dummyIsCreatedSpace
              ? null
              : PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'private',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subtext("Make private"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subtext(
                              "Delete space",
                              color: RED,
                            ),
                          ],
                        ),
                      )
                    ];
                  },
                  // offset: const Offset(0, 40),
                  color: WHITE,
                  elevation: 2,
                  child: const Icon(
                    Icons.more_vert,
                  ),
                ),
        ),
        ySpace(height: 30),
        StickyHeader(
          header: Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: BORDER),
              ),
              color: WHITE,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tabHeader(
                  isActive: currentTabIndex == 0,
                  title: "Discussion",
                  onTap: () {
                    setState(() {
                      currentTabIndex = 0;
                    });
                  },
                ),
                xSpace(width: 10),
                tabHeader(
                  isActive: currentTabIndex == 1,
                  title: "About",
                  onTap: () {
                    setState(() {
                      currentTabIndex = 1;
                    });
                  },
                ),
                xSpace(width: 10),
                tabHeader(
                  isActive: currentTabIndex == 2,
                  title: "Members",
                  onTap: () {
                    setState(() {
                      currentTabIndex = 2;
                    });
                  },
                ),
              ],
            ),
          ),
          content: getTabBody(),
        ),
      ],
    );
  }

  getTabBody() {
    switch (currentTabIndex) {
      case 0:
        return const SpaceDiscussionTab();
      case 1:
        return const SpaceAboutTab();
      case 2:
        return const SpaceMembersTab();
      default:
        return const SpaceDiscussionTab();
    }
  }
}
