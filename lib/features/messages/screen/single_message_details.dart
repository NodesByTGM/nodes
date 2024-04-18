import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class SingleMessageDetails extends StatefulWidget {
  const SingleMessageDetails({super.key});

  static const String routeName = "/single_message_details_screen";

  @override
  State<SingleMessageDetails> createState() => _SingleMessageDetailsState();
}

class _SingleMessageDetailsState extends State<SingleMessageDetails> {
  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isCancel: false,
      appBarBottomBorder: false,
      // backgroundColor: PROFILEBG,
      title: Column(
        children: [
          CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: cachedNetworkImage(imgUrl: ""),
            ),
          ),
          labelText("Robert Fox"),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: PopupMenuButton<String>(
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
            child: Icon(
              MdiIcons.dotsHorizontal,
            ),
          ),
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20),
              itemCount: 20,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (c, i) {
                return ChatCard(
                  fromMe: i % 2 == 0,
                  text:
                      "Animations can enhance user engagement, but use them judiciously. Subtle animations for transitions or highlighting elements can make the site feel dynamic without overwhelming users.",
                  time: TimeOfDay.now(),
                );
              },
              separatorBuilder: (c, i) => ySpace(height: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "msg",
                    decoration: FormUtils.formDecoration(
                      hintText: "Write a message",
                    ),
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: FORM_STYLE,
                    onChanged: (val) {},
                  ),
                ),
                xSpace(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.fromMe,
    required this.time,
    required this.text,
  });

  final bool fromMe;
  final String text;
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    Radius commonRadius = const Radius.circular(10);
    Radius zeroRadius = const Radius.circular(0);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: fromMe ? CHAT_BG : BORDER.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: commonRadius,
              topRight: commonRadius,
              bottomLeft: fromMe ? commonRadius : zeroRadius,
              bottomRight: fromMe ? zeroRadius : commonRadius,
            ),
          ),
          child: subtext(
            text,
            height: 1.6,
            color: BLACK,
          ),
        ),
        Align(
          alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Wrap(
            spacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                MdiIcons.checkAll,
                color: BLACK.withOpacity(0.3),
                size: 18,
              ),
              subtext(
                timeOfDay(time),
                color: BLACK.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
