import 'package:cached_network_image/cached_network_image.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/models/community_post_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';

class CommunityGeneralTab extends StatefulWidget {
  const CommunityGeneralTab({super.key});

  @override
  State<CommunityGeneralTab> createState() => _CommunityGeneralTabState();
}

class _CommunityGeneralTabState extends State<CommunityGeneralTab> {
  TextEditingController msgCtrl = TextEditingController();
  late ComController comCtrl;
  late AuthController authCtrl;
  @override
  initState() {
    comCtrl = locator.get<ComController>();
    authCtrl = locator.get<AuthController>();
    super.initState();
    _reloadData();
  }

  @override
  Widget build(BuildContext context) {
    comCtrl = context.watch<ComController>();
    authCtrl = context.watch<AuthController>();
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            // height: 128,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 16,
              right: 16,
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
                        getShortName("${authCtrl.currentUser.name}"),
                        color: WHITE,
                      ),
                    ),
                    xSpace(width: 10),
                    Expanded(
                      child: FormBuilderTextField(
                        name: "comment",
                        decoration: FormUtils.formDecoration(
                          hintText: "Ask for help from the community...",
                          isTransparentBorder: true,
                          verticalPadding: 10,
                        ),
                        readOnly: true,
                        onTap: () {
                          // open the chat box
                        },
                        style: FORM_STYLE,
                        cursorColor: BLACK,
                        controller: msgCtrl,
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(ImageUtils.attachmentIcon),
                    xSpace(width: 16),
                    SvgPicture.asset(ImageUtils.galleryIcon),
                    xSpace(width: 16),
                    SizedBox(
                      width: 100,
                      child: SubmitBtn(
                        onPressed: () {},
                        title: btnTxt("Post", WHITE),
                        height: 48,
                      ),
                    ),
                    // Form
                  ],
                ),
              ],
            ),
          ),
          ySpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: 10,
                  right: 2,
                ),
                decoration: BoxDecoration(
                  color: WHITE,
                  border: Border.all(width: 0.7, color: BORDER),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  children: [
                    labelText(
                      "Sort by:",
                      color: GRAY,
                      fontSize: 12,
                    ),
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
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          labelText(
                            "Most recent",
                            fontSize: 12,
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: BORDER,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ySpace(height: 20),
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
                    padding: const EdgeInsets.only(top: 27),
                    itemCount: posts.length,
                    itemBuilder: (c, i) {
                      return commentCard(
                        post: posts[i],
                      );
                    },
                    separatorBuilder: (c, i) => ySpace(height: 40),
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
                      shortTime(post.createdAt!),
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
                      value: 'follow',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subtext("Follow this conversation"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'report',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subtext(
                            "Report",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              socialBtn(
                title: '${post.comments?.length}',
                icon: Icons.chat_bubble_outline_outlined,
                onTap: () {},
              ),
              socialBtn(
                title: '${post.likes?.length}',
                icon: Icons.thumb_up_alt_outlined,
                onTap: () {
                  // check if your ID is here, then it means we are unliking... else, we like...
                  likeUnlikeFn(
                      post: post,
                      // check if the current user's ID is found within the likes arr
                      // If NOT found, then proceed to like. hence true
                      // If found, then unlike, hence false...
                      likedPost: post.liked);
                },
              ),
              socialBtn(
                title: 'Share',
                icon: Icons.ios_share_rounded,
                onTap: () async {
                  final res = await shareDoc(context);
                },
              ),
            ],
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
            subtext(
              title,
              fontSize: 14,
              color: GRAY,
            ),
          ],
        ),
      ),
    );
  }

  likeUnlikeFn({
    required bool likedPost,
    required PostModel post,
  }) async {
    likedPost
        ? await comCtrl.unlikeSinglePost(context, post.copyWith(liked: false))
        : await comCtrl.likeSinglePost(context, post.copyWith(liked: true));
  }

  @override
  void dispose() {
    msgCtrl.dispose();
    super.dispose();
  }

  imagePreviewer(
    context, {
    required List<MediaUploadModel> images,
    required int index,
  }) {
    List<ImageProvider> _arr = [];
    for (var i in images) {
      if (!isObjectEmpty(i.url)) {
        _arr.add(CachedNetworkImageProvider(i.url));
      }
    }
    MultiImageProvider multiImageProvider = MultiImageProvider(_arr);

    showImageViewerPager(
      context,
      multiImageProvider,
      useSafeArea: true,
      closeButtonColor: RED,
      backgroundColor: Colors.transparent,
      onPageChanged: (page) {
        // print("page changed to $page");
      },
      onViewerDismissed: (page) {
        // print("dismissed while on page $page");
      },
    );
  }
}
