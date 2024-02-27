import 'package:nodes/features/community/components/create_space_tab.dart';
import 'package:nodes/features/community/components/discover_tab.dart';
import 'package:nodes/features/community/components/space_following_tab.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class NodeSpacesScreen extends StatefulWidget {
  const NodeSpacesScreen({super.key});
  static const String routeName = "/node_spaces_screen";

  @override
  State<NodeSpacesScreen> createState() => _NodeSpacesScreenState();
}

class _NodeSpacesScreenState extends State<NodeSpacesScreen>
    with SingleTickerProviderStateMixin {
  var top = 0.0;
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
    return Container(
      decoration: BoxDecoration(
        gradient: top < 90
            ? null
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x26D5DE21),
                  Color(0x26D5DE21),
                  Color(0x26D5DE21),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
              ),
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
                                  onPressed: () {},
                                  title: btnTxt(
                                    "See Community",
                                    WHITE,
                                  ),
                                ),
                              ),
                              if (currentTabIndex == 2) ...[
                                xSpace(width: 16),
                                Expanded(
                                  child: OutlineBtn(
                                    onPressed: () {},
                                    borderColor: PRIMARY,
                                    color: WHITE,
                                    height: 48,
                                    child: btnTxt(
                                      "Create space",
                                      PRIMARY,
                                    ),
                                  ),
                                ),
                              ],
                              if (currentTabIndex < 2) const Spacer()
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
                            "Discover",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Tab(
                          height: 30,
                          child: subtext(
                            "Following",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Tab(
                          height: 30,
                          child: subtext(
                            "Created",
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
            const SpaceDiscoverTab(),
            SpaceFollowingTab(discoverBtn: () {
              tabController.index = 0;
            }),
            const CreateSpaceTab(),
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
}
