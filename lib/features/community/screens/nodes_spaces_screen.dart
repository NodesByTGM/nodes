import 'package:nodes/features/community/components/create_new_space.dart';
import 'package:nodes/features/community/components/create_space_tab.dart';
import 'package:nodes/features/community/components/discover_tab.dart';
import 'package:nodes/features/community/components/space_following_tab.dart';
import 'package:nodes/features/community/components/topic_interests_modal.dart';
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
    showWelcomeModal();
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
                                    onPressed: () =>
                                        showCreateSpaceBottomSheet(),
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

  showWelcomeModal() async {
    await Future.delayed(
      const Duration(microseconds: 500),
      () {
        showSimpleDialog(
          context: context,
          backgroundColor: WHITE,
          dismissable: false,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    labelText(
                      "Introducing",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    labelText(
                      "Discover",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      color: PRIMARY,
                    ),
                    labelText(
                      "on Nodes",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                ySpace(height: 40),
                SvgPicture.asset(ImageUtils.multiSpaceEmptyIcon),
                ySpace(height: 40),
                Container(
                  decoration: const BoxDecoration(
                    gradient: linearGradient,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              labelText(
                                "Join amazing spaces",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                              ySpace(height: 10),
                              subtext(
                                "Lorem ipsum dolor sit amet consectetur. Consequat nunc euismod id molestie ",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                height: 1.7,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              labelText(
                                "Learn something community",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                              ySpace(height: 10),
                              subtext(
                                "Lorem ipsum dolor sit amet consectetur. Consequat nunc euismod id molestie ",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                height: 1.7,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 10,
                  ),
                  child: SubmitBtn(
                    onPressed: () {
                      showOptionModal();
                    },
                    title: btnTxt(
                      "Next",
                      WHITE,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showOptionModal() async {
    navigateBack(context);
    await Future.delayed(
      const Duration(microseconds: 500),
      () {
        showSimpleDialog(
          context: context,
          backgroundColor: WHITE,
          dismissable: false,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 0),
          child: const TopicInterest(),
        );
      },
    );
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
