import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class CreateSpaceTab extends StatelessWidget {
  const CreateSpaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: screenPadding,
      child: ListView(
        shrinkWrap: true,
        children: [
          ySpace(),
          const Subsection(
            leftSection: "Created by you",
            withDivider: false,
          ),
          ySpace(height: 24),
          ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) {
              return CommunitySpaceCardTemplate(
                imgUrl:
                    "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
                title: "Lorem ipsum dolor sit amet, con...",
                height: 300,
                marginRight: 0,
                onTap: () {},
              );
            },
            separatorBuilder: (c, i) => ySpace(height: 24),
          ),
          ySpace(height: 24),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  int _ = index + 1;
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.only(
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6, color: BORDER),
                        // borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: labelText("$_"),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
