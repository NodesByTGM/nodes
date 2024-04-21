import 'package:nodes/utilities/constants/exported_packages.dart';

class QuickSetupCard extends StatelessWidget {
  const QuickSetupCard({
    super.key,
    required this.icon,
    required this.title,
    required this.btnTitle,
    required this.onTap,
     this.borderColor = const Color(0xFF000000),
  });

  final String icon;
  final String title;
  final String btnTitle;
  final Color borderColor;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      padding: const EdgeInsets.symmetric(
        vertical: 26,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.7, color: borderColor),
        color: WHITE,
        image: const DecorationImage(
          image: AssetImage(ImageUtils.dottedBgOverlay),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              SvgPicture.asset(icon)
            ],
          ),
          ySpace(height: 32),
          SubmitBtn(
            onPressed: () => onTap(),
            title: btnTxt(
              btnTitle,
              WHITE,
            ),
          ),
        ],
      ),
    );
  }
}
