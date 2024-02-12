import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/horizontal_sliding_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class DashboardSingleItemDetailsScreen extends StatefulWidget {
  const DashboardSingleItemDetailsScreen({super.key});
  static const String routeName = "/dashboard_single_item_details";
  @override
  State<DashboardSingleItemDetailsScreen> createState() =>
      _DashboardSingleItemDetailsScreenState();
}

class _DashboardSingleItemDetailsScreenState
    extends State<DashboardSingleItemDetailsScreen> {
  TextEditingController commentCtrl = TextEditingController();
  String? commentMsg;
  bool allowPubToProfile = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // will be using another controller instead of auth, for making the API calls...
    return Consumer2<NavController, AuthController>(
      builder: (context, navCtrl, authCtrl, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ySpace(height: 40),
              GestureDetector(
                onTap: () {
                  navCtrl.popPageListStack();
                },
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_left,
                    ),
                    labelText(
                      "Go back",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              ySpace(height: 40),
              subtext(
                "Top Movies",
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              ySpace(height: 24),
              labelText(
                "Lorem ipsum dolor sit amet, consectetur.",
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              ySpace(height: 8),
              subtext(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              ySpace(height: 40),
              Container(
                height: 340,
                decoration: BoxDecoration(
                  color: GRAY,
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage(ImageUtils.appIcon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ySpace(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: subtext(
                  "Posted on ${fullDate(DateTime.now())}",
                  fontSize: 12,
                ),
              ),
              ySpace(height: 40),
              GestureDetector(
                onTap: () {
                  showCommentBottomSheet();
                },
                child: const Subsection(
                  leftSection: "More like this",
                ),
              ),
              const HorizontalSlidingCards(
                dataSource: HorizontalSlidingCardDataSource.MoreLikeThis,
              ),
            ],
          ),
        );
      },
    );
  }

// Save yourself the hassle, and have this as a separate stateful widget file
  showCommentBottomSheet() {
    commentCtrl.clear();
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
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "Comments (20)",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: BORDER),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            cachedNetworkImage(
                              imgUrl: "",
                              size: 30,
                              shape: BoxShape.circle,
                            ),
                            xSpace(width: 10),
                            Expanded(
                              child: labelText(
                                "Jane Doe",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        ySpace(height: 20),
                        FormBuilderTextField(
                          name: "comment",
                          decoration: FormUtils.formDecoration(
                            hintText: "What are your thoughts?",
                            isTransparentBorder: true,
                            verticalPadding: 10,
                          ),
                          keyboardType: TextInputType.text,
                          style: FORM_STYLE,
                          cursorColor: BLACK,
                          maxLines: 5,
                          controller: commentCtrl,
                          onChanged: (value) => commentMsg = trimValue(value),
                        ),
                        ySpace(height: 20),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              child: OutlineBtn(
                                onPressed: () {},
                                borderColor: Colors.transparent,
                                child: btnTxt(
                                  "Cancel",
                                ),
                              ),
                            ),
                            xSpace(width: 20),
                            Expanded(
                              child: SubmitBtn(
                                onPressed: null,
                                title: btnTxt(
                                  "Comment",
                                  WHITE,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ySpace(height: 16),
                  GestureDetector(
                    onTap: () => pubToProfileBtn(setState),
                    child: Wrap(
                      spacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Checkbox(
                          value: allowPubToProfile,
                          activeColor: PRIMARY,
                          onChanged: (val) => pubToProfileBtn(setState),
                        ),
                        subtext(
                          "Also publish to my profile",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  ySpace(height: 32),
                  PopupMenuButton<String>(
                    onSelected: (value) {},
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'Latest',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              subtext("Latest"),
                            ],
                          ),
                        )
                      ];
                    },
                    offset: const Offset(0, 40),
                    color: WHITE,
                    elevation: 2,
                    child: Container(
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
                        children: [
                          labelText(
                            "Latest",
                            color: GRAY,
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: BORDER,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ySpace(height: 32),
                  // Comment Section
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (c, i) {
                      return SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: cachedNetworkImage(
                                imgUrl: "",
                                size: 30,
                                shape: BoxShape.circle,
                              ),
                              title: labelText(
                                "Jane Doe",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              subtitle: subtext(
                                shortTime(DateTime.now()),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: FORM_TEXT,
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {},
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 'Report',
                                      child: subtext(
                                        "Report this comment",
                                        color: RED,
                                      ),
                                    )
                                  ];
                                },
                                offset: const Offset(0, 40),
                                color: WHITE,
                                elevation: 2,
                                child: const Icon(
                                  Icons.more_horiz_outlined,
                                ),
                              ),
                            ),
                            ySpace(height: 24),
                            labelText(
                              "Lorem ipsum dolor sit amet consectetur. Pharetra elementum mattis et duis dis.",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            ySpace(height: 24),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Wrap(
                                    spacing: 8,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.thumb_down_outlined,
                                        size: 13,
                                      ),
                                      subtext("2", fontSize: 12),
                                    ],
                                  ),
                                ),
                                xSpace(width: 16),
                                GestureDetector(
                                  onTap: () {},
                                  child: Wrap(
                                    spacing: 8,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.thumb_up_outlined,
                                        size: 13,
                                      ),
                                      subtext("2", fontSize: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            customDivider()
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (c, i) => ySpace(height: 10),
                  ),
                  ySpace(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  pubToProfileBtn(StateSetter setState) {
    setState(() {
      allowPubToProfile = !allowPubToProfile;
    });
  }

  @override
  void dispose() {
    commentCtrl.dispose();
    super.dispose();
  }
}
