import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  TextEditingController commentCtrl = TextEditingController();
  String? commentMsg;
  bool allowPubToProfile = false;
  @override
  void initState() {
    commentCtrl.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      fontWeight: FontWeight.w500,
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
                focusNode: FocusNode(),
                autofocus: true,
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
                      foregroundColor: RED,
                      child: btnTxt(
                        "Cancel",
                      ),
                    ),
                  ),
                  xSpace(width: 20),
                  Expanded(
                    child: SubmitBtn(
                      // onPressed: null,
                      onPressed: () {},
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
                      socialInteractionIconWithVal(
                        content: "2",
                        icon: Icons.thumb_down_outlined,
                        onTap: () {},
                      ),
                      xSpace(width: 16),
                      socialInteractionIconWithVal(
                        content: "2",
                        icon: Icons.thumb_up_outlined,
                        onTap: () {},
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
