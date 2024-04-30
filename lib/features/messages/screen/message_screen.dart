import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/messages/screen/single_message_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  static const String routeName = "/message_screen";

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isCancel: false,
      appBarBottomBorder: false,
      leading: const SizedBox.shrink(),
      title: labelText("Messages"),
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
          FormBuilderTextField(
            name: "search",
            decoration: FormUtils.formDecoration(
              hintText: "Search for chats",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                ),
              ),
              verticalPadding: 12,
            ),
            keyboardType: TextInputType.emailAddress,
            style: FORM_STYLE,
            onChanged: (val) {},
          ),
          Expanded(
            child: Consumer<AuthController>(builder: (context, aCtrl, _) {
              if (1 < 2) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      labelText("Coming Soon !!!"),
                      ySpace(height: 10),
                      subtext(
                        "We're working on making this awesome for you,\nbut it's not quite ready yet.",
                        textAlign: TextAlign.center,
                      ),
                      ySpace(height: 10),
                      SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                    ],
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20),
                itemCount: 20,
                itemBuilder: (c, i) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                    splashColor: TRANSPARENT,
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: cachedNetworkImage(imgUrl: ""),
                      ),
                    ),
                    title: labelText(
                      "Cameron Williamson",
                    ),
                    subtitle: subtext(
                      "Not too bad, just trying to catch up on some work. How about you?",
                      maxLines: 1,
                    ),
                    trailing: Column(
                      children: [
                        subtext("5s"),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: SECONDARY,
                          ),
                          child: Center(
                            child: subtext(
                              "1",
                              color: WHITE,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      navigateTo(context, SingleMessageDetails.routeName);
                    },
                  );
                },
                separatorBuilder: (c, i) => customDivider(),
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      navigateBack(context);
                    },
                    child: labelText(
                      "Go Back",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                xSpace(width: 16),
                Expanded(
                  flex: 2,
                  child: SubmitBtn(
                    onPressed: null,
                    title: btnTxt(
                      "Mark all as read",
                      WHITE,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
