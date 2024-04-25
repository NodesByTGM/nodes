// ignore_for_file: deprecated_member_use

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/profile/components/interactions_tab.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class IndividualGuestProfileScreen extends StatefulWidget {
  const IndividualGuestProfileScreen({
    super.key,
    this.id,
  });
  static const String routeName = "/individual_guest_profile_screen";

  final String? id;

  @override
  State<IndividualGuestProfileScreen> createState() =>
      _IndividualGuestProfileScreenState();
}

class _IndividualGuestProfileScreenState
    extends State<IndividualGuestProfileScreen> {
  late ComController comCtrl;
  UserModel? userData;

  @override
  void initState() {
    comCtrl = locator.get<ComController>();
    safeNavigate(() => fetchUserById());
    super.initState();
  }

  fetchUserById() async {
    userData = await comCtrl.fetchSingleUser(context, "${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ComController>(builder: (context, cCtrl, _) {
      if (cCtrl.isFetchingSingleGeneralUser || isObjectEmpty(userData)) {
        // show simmer
        return const ProfileShimmerLoader();
      }
      UserModel user = userData as UserModel;
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
                    imgUrl: "${user.avatar?.url}",
                    size: 100,
                  ),
                  title: labelText(
                    "${user.name}",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  subtitle: labelText(
                    "@${user.username}",
                    fontSize: 14,
                    color: GRAY,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ySpace(height: 24),
                CustomDottedBorder(
                  child: SizedBox(
                    width: screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(
                          !isObjectEmpty(user.headline)
                              ? "${user.headline}"
                              : "Your headline and bio goes here",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        ySpace(height: 10),
                        subtext(
                          !isObjectEmpty(user.bio)
                              ? "${user.bio}"
                              : "Share more about yourself and what you hope to accomplish",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
                ySpace(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageUtils.mapLocationIcon,
                            color: GRAY,
                          ),
                          xSpace(width: 5),
                          subtext(
                            !isObjectEmpty(user.location)
                                ? "${user.location}"
                                : "Location",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GRAY,
                          ),
                        ],
                      ),
                    ),
                    xSpace(width: 10),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 15,
                      children: userSocials(user),
                    ),
                  ],
                ),
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
    });
  }
}
