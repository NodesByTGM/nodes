import 'package:nodes/features/community/components/community_connections_tab.dart';
import 'package:nodes/features/community/components/community_discover_tab.dart';
import 'package:nodes/features/community/components/community_tab.dart';
import 'package:nodes/features/community/components/create_new_space.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class NodeCommunityScreen extends StatefulWidget {
  const NodeCommunityScreen({super.key});
  static const String routeName = "/node_community_screen";

  @override
  State<NodeCommunityScreen> createState() => _NodeCommunityScreenState();
}

class _NodeCommunityScreenState extends State<NodeCommunityScreen> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PROFILEBG,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            padding: screenPadding,
            color: WHITE,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ySpace(height: 32),
                labelText(
                  "Welcome to Nodes Community!",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                ySpace(height: 16),
                subtext(
                  "We believe in the power of every individual's creative spark. ",
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: SubmitBtn(
                //         onPressed: () {
                //           // context
                //           //     .read<NavController>()
                //           //     .updatePageListStack(NodeSpacesScreen.routeName);
                //           showSuccess(message: "Coming Soon");
                //         },
                //         title: btnTxt(
                //           "See spaces",
                //           WHITE,
                //         ),
                //       ),
                //     ),
                //     const Spacer()
                //   ],
                // ),
                ySpace(height: 40),
                FormBuilderTextField(
                  name: "search",
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
                    title: "Connections",
                    onTap: () {
                      setState(() {
                        currentTabIndex = 1;
                      });
                    },
                  ),
                  xSpace(width: 10),
                  tabHeader(
                    isActive: currentTabIndex == 2,
                    title: "Community",
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

  getTabBody() {
    switch (currentTabIndex) {
      case 0:
        return const CommunityDiscoverTab();
      case 1:
        return const CommunityConnectionsTab();
      case 2:
        return const CommunityTab();
      default:
        return const CommunityDiscoverTab();
    }
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
