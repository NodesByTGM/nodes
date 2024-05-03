import 'package:nodes/utilities/constants/exported_packages.dart';

class CMSCardTemplate extends StatelessWidget {
  const CMSCardTemplate({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.description,
    this.height,
    required this.onTap,
  });

  final String imgUrl;
  final String title;
  final String description;
  final double? height;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: cachedNetworkImage(
                imgUrl: imgUrl,
                size: screenWidth(context),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: BLACK.withOpacity(0.5),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: WHITE,
                maxLine: 2,
              ),
              subtext(
                description,
                fontSize: 14,
                color: WHITE,
                maxLine: 2,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    labelText(
                      "Learn more",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: WHITE,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: WHITE,
                      size: 20,
                    ),
                  ],
                ),
              ),
              ySpace(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
