// ignore_for_file: deprecated_member_use

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/components/events_tab.dart';
import 'package:nodes/features/profile/components/jobs_tab.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/profile/components/projects_tab.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';
import 'package:sticky_headers/sticky_headers.dart';

class BusinessGuestProfileScreen extends StatefulWidget {
  const BusinessGuestProfileScreen({
    super.key,
    this.id,
  });
  static const String routeName = "/business_guest_profile_screen";

  final String? id;

  @override
  State<BusinessGuestProfileScreen> createState() =>
      _BusinessGuestProfileScreenState();
}

class _BusinessGuestProfileScreenState
    extends State<BusinessGuestProfileScreen> {
  int currentIndex = 0;
  late ComController comCtrl;
  UserModel? userData;
  BusinessAccountModel? business;

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
      BusinessAccountModel business =
          userData?.business as BusinessAccountModel;
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
                    imgUrl: "${business.logo?.url}",
                    size: 100,
                  ),
                  title: labelText(
                    capitalize("${business.name}"),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ySpace(height: 2),
                      subtext(
                        shortDate(business.yoe ?? DateTime.now()),
                        // shortDate(DateTime.now()),
                        color: GRAY,
                      ),
                      // ySpace(height: 5),
                      // Wrap(
                      //   spacing: 2,
                      //   crossAxisAlignment: WrapCrossAlignment.center,
                      //   children: [
                      //     labelText(
                      //       "26",
                      //       fontSize: 12,
                      //     ),
                      //     subtext(
                      //       "Followers",
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ],
                      // ),
                    ],
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
                          !isObjectEmpty(business.headline)
                              ? "${business.headline}"
                              : "Your headline and bio goes here",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        ySpace(height: 10),
                        subtext(
                          !isObjectEmpty(business.bio)
                              ? "${business.bio}"
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
                            !isObjectEmpty(business.location)
                                ? "${business.location}"
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
                      children: userBusinessSocials(business),
                    ),
                  ],
                ),
                ySpace(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlineBtn(
                        onPressed: () async {
                          await shareDoc(context);
                        },
                        borderColor: PRIMARY,
                        color: WHITE,
                        height: 48,
                        child: btnTxt(
                          "Share Profile",
                          PRIMARY,
                        ),
                      ),
                    ),
                  ],
                ),
                ySpace(height: 32),
              ],
            ),
          ),
          //
          //
          //
          StickyHeaderBuilder(
            builder: (context, stuckAmount) {
              return Container(
                padding: const EdgeInsets.only(top: 5),
                // color: stuckAmount <= -0.54 ? WHITE : null,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: BORDER),
                  ),
                  color: WHITE,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tabHeader(
                      isActive: currentIndex == 0,
                      title: "Jobs",
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                    ),
                    tabHeader(
                      isActive: currentIndex == 1,
                      title: "Projects",
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                    ),
                    tabHeader(
                      isActive: currentIndex == 2,
                      title: "Events",
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: getTabBody(),
            ),
          ),
          //
        ],
      );
    });
  }

  getTabBody() {
    switch (currentIndex) {
      case 0:
        // Call the Model-converter-function here...
        return JobsTab(
          jobs: userData?.jobs ?? [],
        );
      case 1:
        return ProjectsTab(
          // Removed the isBusiness, so i'd be able to view the Project
          isGuest: true,
          projects: userData?.projects ?? [],
        );
      case 2:
        return EventsTab(
          // Call the Model-converter-function here...
          events: userData?.events ?? [],
        );
      default:
        return JobsTab(
          jobs: userData?.jobs ?? [],
        );
    }
  }
}
