import 'package:nodes/utilities/constants/exported_packages.dart';

class CustomCardTemplate extends StatelessWidget {
  const CustomCardTemplate({
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
        image: DecorationImage(
          image: NetworkImage(
            imgUrl,
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.multiply,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText(
              title,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: WHITE,
              // maxLine: 1,
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
    );
  }
}
