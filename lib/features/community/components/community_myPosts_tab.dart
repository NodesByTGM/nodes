import 'package:nodes/utilities/constants/exported_packages.dart';

class CommunityMyPostTab extends StatefulWidget {
  const CommunityMyPostTab({super.key});

  @override
  State<CommunityMyPostTab> createState() => _CommunityMyPostTabState();
}

class _CommunityMyPostTabState extends State<CommunityMyPostTab> {
  TextEditingController msgCtrl = TextEditingController();
  bool commentIsExpanded = false;
  var _ = 158.0;
  @override
  void initState() {
    super.initState();
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
                      "Hi Aderinsola!",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ySpace(height: 20),
                    subtext(
                      "Posts you've made, will appear here",
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
            margin: const EdgeInsets.only(top: 40),
            child: ListView(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                ySpace(height: 40),
                ySpace(height: 24),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (c, i) {
                    return commentCard();
                  },
                  separatorBuilder: (c, i) => ySpace(height: 20),
                ),
                ySpace(height: 150),
              ],
            ),
          );
  }

  Container commentCard() {
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
                child: labelText("JD", color: WHITE),
              ),
              xSpace(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      "Aderinsola Adejuwon",
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
              children: [
                labelText(
                  "Lorem ipsum dolor sit amet consectetur. Feugiat senectus ut aenean commodo dictum malesuada. Imperdiet orci magnis donec malesuada mi massa magna lectus viverra. Nunc quam congue vulputate etiam dapibus vel suscipit cras pretium. Ut donec vulputate etiam consectetur vel.",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
                ySpace(height: 20),
                Container(
                  width: screenWidth(context),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: cachedNetworkImage(
                      imgUrl:
                          "https://images.pexels.com/photos/13734188/pexels-photo-13734188.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                    ),
                  ),
                ),
              ],
            ),
          ),
          ySpace(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              socialBtn(
                title: '24',
                icon: Icons.chat_bubble_outline_outlined,
                onTap: () {},
              ),
              socialBtn(
                title: '24',
                icon: Icons.thumb_up_alt_outlined,
                onTap: () {},
              ),
              socialBtn(
                title: 'Share',
                icon: Icons.ios_share_rounded,
                onTap: () {},
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
}
