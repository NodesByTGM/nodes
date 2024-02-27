import 'package:nodes/utilities/constants/exported_packages.dart';

class CommunitySpaceCardTemplate extends StatelessWidget {
  const CommunitySpaceCardTemplate({
    super.key,
    required this.imgUrl,
    required this.title,
    this.onTapTitle,
    this.height,
    this.width,
    this.marginRight,
    required this.onTap,
  });

  final String imgUrl;
  final String title;
  final String? onTapTitle;
  final double? height;
  final double? width;
  final double? marginRight;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: marginRight ?? 20),
      padding: const EdgeInsets.only(top: 25),
      width: width ?? screenWidth(context) * 0.6,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.7, color: BORDER),
        color: WHITE,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cachedNetworkImage(
                  imgUrl: "",
                  size: 80,
                ),
                GestureDetector(
                  onTap: onTap ,
                  child: labelText(
                    onTapTitle ?? "Join space",
                    color: PRIMARY,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            ySpace(height: 24),
            labelText(
              "Main Title",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            ySpace(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset(ImageUtils.multipleUserIcon),
                      xSpace(width: 5),
                      subtext(
                        "555 members",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  xSpace(width: 10),
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset(ImageUtils.commentOutlineIcon),
                      xSpace(width: 5),
                      subtext(
                        "3 new posts last week",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ySpace(height: 16),
            labelText(
              title,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              // maxLine: 1,
            ),
            ySpace(height: 24),
          ],
        ),
      ),
    );
  }
}
