import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/community/view_model/com_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class SpaceFollowingTab extends StatelessWidget {
  const SpaceFollowingTab({super.key, required this.discoverBtn});

  final GestureTapCallback discoverBtn;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 1 > 2
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
                        "You are just getting started.\nDiscover spaces to follow now.",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      ySpace(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SubmitBtn(
                          onPressed: discoverBtn,
                          title: btnTxt(
                            "Discover spaces",
                            WHITE,
                          ),
                        ),
                      ),
                      ySpace(height: 40),
                      SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: screenPadding,
              margin: const EdgeInsets.only(top: 40),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ySpace(),
                  const Subsection(
                    leftSection: "Spaces you follow",
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
                        onTap: () {
                          // send this space details to provider...
                          context
                              .read<ComController>()
                              .setDummyIsCreatedSpaceVal(false);
                          context.read<NavController>().updatePageListStack(
                              SpaceDetailsScreen.routeName);
                        },
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
            ),
    );
  }
}
