import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/components/space_about_tab.dart';
import 'package:nodes/features/community/components/space_discussion_tab.dart';
import 'package:nodes/features/community/components/space_members_tab.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class SpaceDetailsScreen extends StatefulWidget {
  const SpaceDetailsScreen({super.key});
  static const String routeName = "/space_details_screen";

  @override
  State<SpaceDetailsScreen> createState() => _SpaceDetailsScreenState();
}

class _SpaceDetailsScreenState extends State<SpaceDetailsScreen>
    with SingleTickerProviderStateMixin {
  int currentTabIndex = 0;

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: TRANSPARENT,
            expandedHeight: screenHeight(context) * 0.55,
            pinned: true,
            scrolledUnderElevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ySpace(height: 40),
                      GestureDetector(
                        onTap: () {
                          context.read<NavController>().popPageListStack();
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
                        onTapTitle: "Invite a friend",
                        onTap: () {},
                      ),
                    ],
                  ),
                  title: TabBar(
                    padding: const EdgeInsets.all(0),
                    indicatorWeight: 1,
                    labelPadding: const EdgeInsets.all(0),
                    splashFactory: NoSplash.splashFactory,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: TRANSPARENT,
                    controller: tabController,
                    onTap: (int i) {
                      setState(() {
                        currentTabIndex = i;
                      });
                    },
                    tabs: [
                      Tab(
                        height: 30,
                        child: subtext(
                          "Discussion",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Tab(
                        height: 30,
                        child: subtext(
                          "About",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Tab(
                        height: 30,
                        child: subtext(
                          "Members",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // centerTitle: true,
                );
              },
            ),
            leading: const SizedBox.shrink(),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: const [
          SpaceDiscussionTab(),
          SpaceAboutTab(),
          SpaceMembersTab(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
