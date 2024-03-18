import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/components/create_new_space.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class CreateSpaceTab extends StatelessWidget {
  const CreateSpaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 1 > 2
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              decoration: BoxDecoration(
                color: WHITE,
                border: Border.all(
                  width: 0.7,
                  color: BORDER,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
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
                        "You haven't created a space yet\nGet started now and create one",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      ySpace(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: SubmitBtn(
                          onPressed: () => showCreateSpaceBottomSheet(context),
                          title: btnTxt(
                            "Create a spaces",
                            WHITE,
                          ),
                        ),
                      ),
                      SvgPicture.asset(ImageUtils.spaceEmptyIcon),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: screenPadding,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                        onTapTitle: "View space",
                        onTap: () {
                          // send this space details to provider...
                          context
                              .read<ComController>()
                              .setDummyIsCreatedSpaceVal(true);
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

  showCreateSpaceBottomSheet(BuildContext context) {
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
      elevation: 0.0,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "Create a new space",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: const CreateNewSpace(),
            );
          },
        );
      },
    );
  }
}
