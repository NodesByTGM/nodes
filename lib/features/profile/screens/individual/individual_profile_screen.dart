import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/profile/components/interactions_tab.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/profile/screens/individual/edit_individual_profile_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class IndividualProfileScreen extends StatelessWidget {
  const IndividualProfileScreen({super.key});
  static const String routeName = "/individual_profile_screen";

  @override
  Widget build(BuildContext context) {
    bool isRegistered = true;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            top: 40,
          ),
          child: ProfileCard(
            child: Column(
              children: [
                cachedNetworkImage(
                  imgUrl:
                      "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                  size: 100,
                ),
                ySpace(height: 24),
                labelText(
                  "Jane Doe",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 8),
                labelText(
                  "@JD",
                  fontSize: 14,
                  color: GRAY,
                  fontWeight: FontWeight.w500,
                ),
                ySpace(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageUtils.mapLocationIcon,
                            color: GRAY,
                          ),
                          xSpace(width: 5),
                          subtext(
                            "Add Location",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GRAY,
                          ),
                        ],
                      ),
                      xSpace(width: 10),
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageUtils.chainLinkIcon,
                            color: GRAY,
                          ),
                          xSpace(width: 5),
                          subtext(
                            "Add Websites",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GRAY,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ySpace(height: 40),
                CustomDottedBorder(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(
                        "Your headline and bio goes here",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      ySpace(height: 10),
                      subtext(
                        // "Share more about yourself and what you hope to accomplish",
                        "Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. Lorem ipsum dolor sit amet consectetur. Cum amet id lectus viverra faucibus. Arcu eget hendrerit ut dictumst id. ",

                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                if (isRegistered) ...[
                  ySpace(height: 40),
                  SubmitBtn(
                    onPressed: () {
                      context.read<NavController>().updatePageListStack(
                          EditIndividualProfileScreen.routeName);
                    },
                    height: 48,
                    title: btnTxt(
                      "Edit Your Profile",
                      WHITE,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        ySpace(),
        // StickyHeader(
        //   header: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       decoration: const BoxDecoration(
        //           // gradient: profileLinearGradient,
        //           // color: Color.fromARGB(173, 213, 222, 33),
        //           ),
        //       child: Row(
        //         children: [
        //           Container(
        //             padding: const EdgeInsets.only(bottom: 10),
        //             margin: const EdgeInsets.only(bottom: 10),
        //             decoration: const BoxDecoration(
        //               border: Border(
        //                 bottom: BorderSide(width: 1, color: PRIMARY),
        //               ),
        //             ),
        //             child: labelText(
        //               "Interactions",
        //               fontSize: 16,
        //               color: PRIMARY,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   content: const ProfileCard(
        //     child: InteractionsTab(),
        //   ),
        // ),
        StickyHeaderBuilder(
          builder: (context, stuckAmount) {
            return Container(
              padding: const EdgeInsets.only(top: 10),
              color: stuckAmount <= -0.54 ? WHITE : null,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: PRIMARY),
                      ),
                    ),
                    child: labelText(
                      "Interactions",
                      fontSize: 16,
                      color: PRIMARY,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
          content: const ProfileCard(
            child: InteractionsTab(),
          ),
        ),
      ],
    );
  }
}
