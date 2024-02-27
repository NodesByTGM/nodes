import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';

class SpaceMembersTab extends StatefulWidget {
  const SpaceMembersTab({super.key});

  @override
  State<SpaceMembersTab> createState() => _SpaceMembersTabState();
}

class _SpaceMembersTabState extends State<SpaceMembersTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
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
          ySpace(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText("Members in this space"),
                ySpace(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: subtext(
                    "Invite a friend",
                    color: PRIMARY,
                  ),
                ),
                ySpace(height: 20),
                FormBuilderTextField(
                  name: "email",
                  decoration: FormUtils.formDecoration(
                    hintText: "ex: acting",
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
                ySpace(height: 40),
                ListView.separated(
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return ListTile(
                      title: labelText(
                        "Name of member",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: subtext(
                        "Joined ${shortDate(DateTime.now())}",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  },
                  separatorBuilder: (c, i) => const Divider(
                    thickness: .8,
                    height: 20,
                  ),
                )
              ],
            ),
          ),
          ySpace(height: 40),
        ],
      ),
    );
  }
}
