import 'package:nodes/utilities/constants/exported_packages.dart';

class CommunityCardTemplate extends StatelessWidget {
  const CommunityCardTemplate({
    super.key,
    required this.imgUrl,
    required this.title,
    this.height,
    required this.onTap,
  });

  final String imgUrl;
  final String title;
  final double? height;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(top: 25),
      width: screenWidth(context) * 0.6,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.7, color: BORDER),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                cachedNetworkImage(
                  imgUrl: "",
                  size: 30,
                  borderRadius: 100,
                ),
                xSpace(width: 10),
                Expanded(
                  child: labelText(
                    "Directors room ",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ySpace(height: 8),
            labelText(
              title,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              // maxLine: 1,
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
                      labelText(
                        "1",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      labelText(
                        "comment",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: BORDER,
                    ),
                  ),
                  Wrap(
                    spacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labelText(
                        "34",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      labelText(
                        "interactions",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ySpace(height: 24),
          ],
        ),
      ),
    );
  }
}
