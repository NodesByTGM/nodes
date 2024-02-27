import 'package:nodes/utilities/constants/exported_packages.dart';

class SpaceDiscussionTab extends StatefulWidget {
  const SpaceDiscussionTab({super.key});

  @override
  State<SpaceDiscussionTab> createState() => _SpaceDiscussionTabState();
}

class _SpaceDiscussionTabState extends State<SpaceDiscussionTab> {
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
            height: 200,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(8),
              color: BORDER,
            ),
          ),
          ySpace(height: 40),
        ],
      ),
    );
  }
}
