import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_followed_tab.dart';
import 'package:nodes/features/community/components/community_general_tab.dart';
import 'package:nodes/features/community/components/community_myPosts_tab.dart';
import 'package:nodes/features/community/components/create_new_space.dart';
import 'package:nodes/features/community/screens/nodes_spaces_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class NodeCommunityScreen extends StatefulWidget {
  const NodeCommunityScreen({super.key});
  static const String routeName = "/node_community_screen";

  @override
  State<NodeCommunityScreen> createState() => _NodeCommunityScreenState();
}

class _NodeCommunityScreenState extends State<NodeCommunityScreen>
    with SingleTickerProviderStateMixin {
  var top = 91.0;
  int currentTabIndex = 0;

  late TabController tabController;

  @override
  void initState() {
    // Launch the into modal on init...
    // But first check if user has selected any topics, if yes, then don't launch, else.. launch
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
    return Container(
      decoration: BoxDecoration(
        gradient: top < 90 ? null : linearGradient,
      ),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: TRANSPARENT,
              expandedHeight: screenHeight(context) * 0.45,
              pinned: true,
              scrolledUnderElevation: 0,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  _getTop(top);
                  return FlexibleSpaceBar(
                    background: Padding(
                      padding: screenPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ySpace(height: 64),
                          labelText(
                            "Welcome to Nodes Spaces!",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          ySpace(height: 16),
                          subtext(
                            "We believe in the power of every individual's creative spark. ",
                          ),
                          ySpace(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: SubmitBtn(
                                  onPressed: () {
                                    context
                                        .read<NavController>()
                                        .updatePageListStack(
                                            NodeSpacesScreen.routeName);
                                  },
                                  title: btnTxt(
                                    "See spaces",
                                    WHITE,
                                  ),
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                          ySpace(height: 40),
                          FormBuilderTextField(
                            name: "email",
                            decoration: FormUtils.formDecoration(
                              hintText: "ex: actors",
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: FORM_STYLE,
                            // controller: searchCtrl,

                            onChanged: (val) {},
                          ),
                        ],
                      ),
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
                            "General",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Tab(
                          height: 30,
                          child: subtext(
                            "Followed",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Tab(
                          height: 30,
                          child: subtext(
                            "My posts",
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
          children: [
            const CommunityGeneralTab(),
            const CommunityFollowedTab(),
            const CommunityMyPostTab(),
          ],
        ),
      ),
    );
  }

  void _getTop(double t) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (top != t) {
        setState(() {
          top = t;
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  showCreateSpaceBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      backgroundColor: WHITE,
      elevation: 0.0,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "Create a new space",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: const CreateNewSpace(),
            );
          },
        );
      },
    );
  }
}
