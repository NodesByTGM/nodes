// ignore_for_file: deprecated_member_use

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/features/profile/components/profile_cards.dart';
import 'package:nodes/features/profile/components/projects_tab.dart';
import 'package:nodes/features/profile/screens/business/edit_business_profile_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:sticky_headers/sticky_headers.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});
  static const String routeName = "/business_profile_screen";

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  int currentIndex = 0;
  bool isRegistered = true;
  late AuthController authCtrl;
  late UserModel user;
  late BusinessAccountModel business;

  @override
  void initState() {
    authCtrl = locator.get<AuthController>();
    user = authCtrl.currentUser;
    business = user.business as BusinessAccountModel;
    super.initState();
    safeNavigate(
        () => context.read<DashboardController>().fetchMyProjects(context));
  }

  @override
  Widget build(BuildContext context) {
    authCtrl = context.watch<AuthController>();
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
              if (isRegistered) ...[
                ySpace(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlineBtn(
                        onPressed: () async {
                          if (isBusinessProfileComplete(business)) {
                            await shareDoc(context);
                          } else {
                            showText(
                              message: "Please update your profile to proceed.",
                            );
                          }
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
                    xSpace(width: 10),
                    Expanded(
                      child: SubmitBtn(
                        height: 48,
                        onPressed: () {
                          context.read<NavController>().updatePageListStack(
                                EditBusinessProfileScreen.routeName,
                              );
                        },
                        title: btnTxt(
                          "Edit Your Profile",
                          WHITE,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
                children: [
                  tabHeader(
                    isActive: currentIndex == 0,
                    title: "Jobs/Events",
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),
                  xSpace(width: 10),
                  tabHeader(
                    isActive: currentIndex == 1,
                    title: "Projects",
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            );
          },
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Consumer<DashboardController>(
              builder: (c, dCtrl, _) {
                return getTabBody(dCtrl);
              },
            ),
          ),
        ),
        //
      ],
    );
  }

  getTabBody(DashboardController dc) {
    return currentIndex == 0
        ? ProjectsTab(
            isBusiness: true,
            projects: dc.myProjectList,
          )
        : ProjectsTab(
            isBusiness: true,
            projects: dc.myProjectList,
          );
  }
}
