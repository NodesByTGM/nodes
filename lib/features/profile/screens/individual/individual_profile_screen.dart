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
        Container(
          color: WHITE,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ySpace(height: 24),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: cachedNetworkImage(
                  imgUrl:
                      "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                  size: 100,
                ),
                title: labelText(
                  "Jane Doe",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: labelText(
                  "@JD",
                  fontSize: 14,
                  color: GRAY,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ySpace(height: 24),
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
                      "Share more about yourself and what you hope to accomplish",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              ySpace(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageUtils.mapLocationIcon,
                        color: GRAY,
                      ),
                      xSpace(width: 5),
                      subtext(
                        "Location",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: GRAY,
                      ),
                    ],
                  ),
                  xSpace(width: 10),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageUtils.chainLinkIcon,
                        color: GRAY,
                      ),
                      xSpace(width: 5),
                      subtext(
                        "Websites",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: GRAY,
                      ),
                    ],
                  ),
                ],
              ),
              ySpace(height: 24),
              if (isRegistered) ...[
                ySpace(height: 10),
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
                ySpace(height: 16),
              ],
            ],
          ),
        ),
        StickyHeaderBuilder(
          builder: (context, stuckAmount) {
            return Container(
              padding: const EdgeInsets.only(top: 28),
              // color: stuckAmount <= -0.54 ? WHITE : null,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: BORDER),
                ),
                color: WHITE,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      left: 16,
                      right: 16,
                    ),
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
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: InteractionsTab(),
          ),
        ),
      ],
    );
  }
}
