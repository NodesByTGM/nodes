import 'package:nodes/utilities/constants/exported_packages.dart';

class SpaceAboutTab extends StatefulWidget {
  const SpaceAboutTab({super.key});

  @override
  State<SpaceAboutTab> createState() => _SpaceAboutTabState();
}

class _SpaceAboutTabState extends State<SpaceAboutTab> {
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
              vertical: 20,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "About this space",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 10),
                subtext(
                  "Lorem ipsum dolor sit amet consectetur. Feugiat senectus ut aenean commodo dictum malesuada. Imperdiet orci magnis donec malesuada mi massa magna lectus viverra. Nunc quam congue vulputate etiam dapibus vel suscipit cras pretium. Ut donec vulputate etiam consectetur vel.",
                  height: 1.8,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          ySpace(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Rules",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 10),
                subtext(
                  "something about rules",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                ySpace(height: 20),
                ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: PRIMARY,
                          child: labelText(
                            "${i + 1}",
                            color: WHITE,
                          ),
                        ),
                        xSpace(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(
                                "Be considerate",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              ySpace(height: 8),
                              subtext(
                                "Lorem ipsum dolor sit amet consectetur. Donec ipsum turpis ut non aliquet mattis.",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (c, i) => ySpace(height: 24),
                ),
              ],
            ),
          ),
          ySpace(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(8),
              color: LIGHT_SECONDARY,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Activity",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 20),
                subtext(
                  "This space is created to blah blah",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                ySpace(height: 20),
                _buildActivityItem(
                  icon: ImageUtils.commentOutlineIcon,
                  title: "30 new posts last week",
                  subtitle: "100 posts last month",
                ),
                ySpace(height: 16),
                _buildActivityItem(
                  icon: ImageUtils.multipleUserIcon,
                  title: "555 members",
                  subtitle: "100 posts last month",
                ),
                ySpace(height: 16),
                _buildActivityItem(
                  icon: ImageUtils.commentOutlineIcon,
                  title: "Created ${formatDate(DateTime.now())}",
                ),
                ySpace(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: subtext(
                      "Invite a friend",
                      color: PRIMARY,
                    ),
                  ),
                )
              ],
            ),
          ),
          ySpace(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(8),
              color: LIGHT_SECONDARY,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText(
                  "Admins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 20),
                ListView.separated(
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        cachedNetworkImage(
                          imgUrl: "",
                          size: 30,
                        ),
                        xSpace(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelText(
                                "Firstname Lastname",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              ySpace(height: 8),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (c, i) => ySpace(height: 20),
                ),
              ],
            ),
          ),
          ySpace(height: 40),
        ],
      ),
    );
  }

  Row _buildActivityItem({
    required String icon,
    required String title,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          height: 25,
        ),
        xSpace(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: isObjectEmpty(subtitle) ? 5 : 0),
                child: labelText(
                  title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ySpace(height: 8),
              if (!isObjectEmpty(subtitle)) ...[
                subtext(
                  "$subtitle",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ],
          ),
        )
      ],
    );
  }
}
