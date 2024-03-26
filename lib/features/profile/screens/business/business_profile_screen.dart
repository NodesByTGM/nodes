import 'package:nodes/core/controller/nav_controller.dart';
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

  @override
  Widget build(BuildContext context) {
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
                  "Name of company",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ySpace(height: 2),
                    subtext(
                      "Year of establishment",
                      color: GRAY,
                    ),
                    ySpace(height: 5),
                    Wrap(
                      spacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        labelText(
                          "26",
                          fontSize: 12,
                        ),
                        subtext(
                          "Followers",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
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
              if (isRegistered) ...[
                ySpace(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlineBtn(
                        onPressed: () async {
                          final res = await shareDoc(context);
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
                              EditBusinessProfileScreen.routeName);
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
            child: getTabBody(),
          ),
        ),
        //
      ],
    );
  }


  getTabBody() {
    return currentIndex == 0
        ? ProjectsTab(
            isBusiness: true,
          )
        : ProjectsTab(
            isBusiness: true,
          );
  }
}
