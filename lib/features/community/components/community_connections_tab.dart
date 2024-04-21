import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/components/community_filter_modal.dart';
import 'package:nodes/features/community/components/people_brand_card.dart';
import 'package:nodes/features/community/models/community_post_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class CommunityConnectionsTab extends StatefulWidget {
  const CommunityConnectionsTab({super.key});

  @override
  State<CommunityConnectionsTab> createState() =>
      _CommunityConnectionsTabState();
}

class _CommunityConnectionsTabState extends State<CommunityConnectionsTab> {
  TextEditingController msgCtrl = TextEditingController();
  bool commentIsExpanded = false;
  // var _ = 158.0;
  // var _ = 158.0;
  late ComController comCtrl;
  late AuthController authCtrl;
  bool isBrand = false;

  @override
  initState() {
    comCtrl = locator.get<ComController>();
    authCtrl = locator.get<AuthController>();
    super.initState();
    _reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return 1 > 2
        ? Container(
            color: WHITE,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ySpace(height: 20),
                    labelText(
                      "Hi ${authCtrl.currentUser.name?.split(" ").first}!",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 20),
                    subtext(
                      "Discover People, Brands you'd like to engage with here...",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    ySpace(height: 40),
                    SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                  ],
                ),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(top: 24),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: showOptionModal,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.7,
                              color: BORDER,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: WHITE,
                          ),
                          child: Wrap(
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(MdiIcons.filterOutline),
                              labelText("Filter view"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.7,
                            color: BORDER,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: WHITE,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBrand = false;
                                });
                              },
                              child: labelText("People"),
                            ),
                            Container(
                              width: 36,
                              height: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                  value: isBrand,
                                  inactiveTrackColor: TAG_CHIP,
                                  activeTrackColor: TAG_CHIP,
                                  inactiveThumbColor: WHITE,
                                  onChanged: (bool value1) {
                                    setState(() {
                                      isBrand = !isBrand;
                                    });
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBrand = true;
                                });
                              },
                              child: labelText("Brands"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ySpace(height: 24),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ComController>(
                    builder: (contex, comCtrl, _) {
                      bool isLoading = comCtrl.isFetchingPost;
                      bool hasData = isObjectEmpty(comCtrl.PostList);
                      if (isLoading || isObjectEmpty(comCtrl.PostList)) {
                        return DataReload(
                          maxHeight: screenHeight(context) * .19,
                          isLoading: isLoading,
                          loader: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ShimmerLoader(
                              scrollDirection: Axis.vertical,
                              width: screenWidth(context),
                              marginBottom: 10,
                            ),
                          ), // Pass the shimmer here...
                          onTap: () => _reloadData(),
                          isEmpty: hasData,
                        );
                      } else {
                        List<PostModel> posts = comCtrl.PostList;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: posts.length,
                          itemBuilder: (c, i) {
                            // return commentCard(
                            //   post: posts[i],
                            // );
                            return PeopleBrandCard(
                              isConnected: true,
                            );
                          },
                          separatorBuilder: (c, i) => ySpace(height: 20),
                        );
                      }
                    },
                  ),
                ),
                ySpace(height: 150),
              ],
            ),
          );
  }

  void _reloadData() {
    safeNavigate(() => comCtrl.fetchAllPosts(context));
  }

  Container commentCard({required PostModel post}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 0.7, color: BORDER),
        borderRadius: BorderRadius.circular(8),
        color: WHITE,
        boxShadow: const [
          BoxShadow(
            offset: Offset(
              1,
              2,
            ),
            blurRadius: 2,
            color: BORDER,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: PRIMARY,
                child: labelText(
                    getShortName(
                      "${post.author?.name}",
                    ),
                    color: WHITE),
              ),
              xSpace(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      capitalize("${post.author?.name}"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    subtext(
                      shortTime(DateTime.now()),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GRAY,
                    ),
                  ],
                ),
              ),
              xSpace(width: 10),
              PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subtext(
                            "Delete",
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
                  Icons.more_horiz,
                ),
              ),
            ],
          ),
          ySpace(height: 20),
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "${post.body}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
                ySpace(height: 20),
                if (!isObjectEmpty(post.attachments)) ...[
                  Container(
                    width: screenWidth(context),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: post.attachments!.length < 2 ? 1 : 2,
                        // childAspectRatio: 1.92,
                        childAspectRatio:
                            post.attachments!.length < 3 ? 1 : 1.92,
                      ),
                      itemCount: post.attachments?.length,
                      itemBuilder: (context, index) {
                        String url = "${post.attachments?[index].url}";
                        return GestureDetector(
                          onTap: () => imagePreviewer(
                            context,
                            images: post.attachments!,
                            index: index,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: cachedNetworkImage(
                              imgUrl: url,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                ySpace(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector socialBtn({
    required String title,
    required IconData icon,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: BORDER.withOpacity(0.2),
        ),
        child: Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              icon,
              color: GRAY,
            ),
            labelText(
              title,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: GRAY,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    msgCtrl.dispose();
    super.dispose();
  }

  showOptionModal() async {
    showSimpleDialog(
      context: context,
      backgroundColor: WHITE,
      dismissable: false,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 0),
      child: const CommunityFilter(),
    );
  }

  
}
