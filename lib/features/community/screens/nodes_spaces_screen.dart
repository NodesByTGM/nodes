import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/create_new_space.dart';
import 'package:nodes/features/community/components/create_space_tab.dart';
import 'package:nodes/features/community/components/discover_tab.dart';
import 'package:nodes/features/community/components/space_following_tab.dart';
import 'package:nodes/features/community/components/topic_interests_modal.dart';
import 'package:nodes/features/community/screens/nodes_community_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class NodeSpacesScreen extends StatefulWidget {
  const NodeSpacesScreen({super.key});
  static const String routeName = "/node_spaces_screen";

  @override
  State<NodeSpacesScreen> createState() => _NodeSpacesScreenState();
}

class _NodeSpacesScreenState extends State<NodeSpacesScreen> {
  int currentTabIndex = 0;

  @override
  void initState() {
    showWelcomeModal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PROFILEBG,
      child: ListView(
        children: [
          Container(
            padding: screenPadding,
            color: WHITE,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ySpace(height: 32),
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
                          context.read<NavController>().updatePageListStack(
                              NodeCommunityScreen.routeName);
                        },
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
                          onPressed: () => showCreateSpaceBottomSheet(),
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
                ySpace(height: 24),
              ],
            ),
          ),
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
                    title: "Discover",
                    onTap: () {
                      setState(() {
                        currentTabIndex = 0;
                      });
                    },
                  ),
                  xSpace(width: 10),
                  tabHeader(
                    isActive: currentTabIndex == 1,
                    title: "Following",
                    onTap: () {
                      setState(() {
                        currentTabIndex = 1;
                      });
                    },
                  ),
                  xSpace(width: 10),
                  tabHeader(
                    isActive: currentTabIndex == 2,
                    title: "Created",
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
      ),
    );
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
              mainAxisSize: MainAxisSize.min,
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

  GestureDetector tabHeader({
    required bool isActive,
    required String title,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isActive ? PRIMARY : TRANSPARENT,
            ),
          ),
        ),
        child: labelText(
          title,
          fontSize: 16,
          color: isActive ? PRIMARY : BLACK,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  getTabBody() {
    switch (currentTabIndex) {
      case 0:
        return const SpaceDiscoverTab();
      case 1:
        return SpaceFollowingTab(discoverBtn: () {
          setState(() {
            currentTabIndex = 0;
          });
        });
      case 2:
        return const CreateSpaceTab();
      default:
        return const SpaceDiscoverTab();
    }
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
