import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/features/auth/views/business_auth/business_auth_screen.dart';
import 'package:nodes/features/auth/views/talent_auth/talent_signup_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TalentAuthScreen extends StatefulWidget {
  const TalentAuthScreen({Key? key}) : super(key: key);

  static const String routeName = "/talentAuthScreen";

  @override
  State<TalentAuthScreen> createState() => _TalentAuthScreenState();
}

class _TalentAuthScreenState extends State<TalentAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      isCancel: false,
      title: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            ImageUtils.appIcon,
            fit: BoxFit.cover,
            height: 18,
            width: 18,
          ),
          titleText(
            "Nodes",
            color: PRIMARY,
          )
        ],
      ),
      centerTitle: false,
      leading: Icon(
        MdiIcons.menu,
        size: 30,
        color: BLACK,
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 32,
          width: 1,
          color: BLACK,
        ),
        xSpace(width: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: PRIMARY,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: labelText(
              "AA",
              color: WHITE,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        xSpace(width: 10)
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ySpace(),
          subtext(
            "FOR TALENTS",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 24),
          labelText(
            "Medium length hero headline goes here",
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
          ySpace(height: 24),
          subtext(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.",
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          ySpace(height: 24),
          SubmitBtn(
            onPressed: _submit,
            title: btnTxt("GET STARTED FOR FREE", WHITE),
          ),
          ySpace(height: 24),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                navigateAndClearPrev(context, BusinessAuthScreen.routeName);
              },
              child: labelText(
                "Sign up as a business instead?",
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: screenHeight(context) * 0.3,
                  decoration: BoxDecoration(
                    color: BORDER,
                    borderRadius: BorderRadius.circular(6),
                    image: const DecorationImage(
                      image: AssetImage(
                        ImageUtils.talentAuthImage,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _submit() async {
    navigateTo(context, TalentSignupScreen.routeName);
  }
}
