import 'package:nodes/utilities/constants/exported_packages.dart';

class TopMovieCardTemplate extends StatelessWidget {
  const TopMovieCardTemplate({
    super.key,
    required this.imgUrl,
    required this.title,
    this.height,
    required this.onTap,
    this.rating = 0,
    required this.ratingTap,
  });

  final String imgUrl;
  final String title;
  final double? height;
  final GestureTapCallback onTap;
  final double rating;
  final GestureTapCallback ratingTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: screenWidth(context) * 0.6,
      height: height,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: cachedNetworkImage(
                  imgUrl:
                      "https://images.pexels.com/photos/20412111/pexels-photo-20412111/free-photo-of-cactus.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                  // imgUrl: imgUrl,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ratingTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(ImageUtils.starIcon),
                          labelText(
                            "$rating",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: WHITE,
                          ),
                        ],
                      ),
                      SvgPicture.asset(ImageUtils.starOutlineIcon),
                    ],
                  ),
                ),
                labelText(
                  title,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: WHITE,
                  // maxLine: 1,
                ),
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
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.only(right: 10),
    //   padding: const EdgeInsets.only(top: 25),
    //   width: screenWidth(context) * 0.6,
    //   height: height,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8),
    //     image: DecorationImage(
    //       image: NetworkImage(
    //         imgUrl,
    //       ),
    //       fit: BoxFit.cover,
    //       colorFilter: ColorFilter.mode(
    //         Colors.black.withOpacity(0.3),
    //         BlendMode.multiply,
    //       ),
    //     ),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         GestureDetector(
    //           onTap: ratingTap,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Wrap(
    //                 spacing: 5,
    //                 crossAxisAlignment: WrapCrossAlignment.center,
    //                 children: [
    //                   SvgPicture.asset(ImageUtils.starIcon),
    //                   labelText(
    //                     "$rating",
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500,
    //                     color: WHITE,
    //                   ),
    //                 ],
    //               ),
    //               SvgPicture.asset(ImageUtils.starOutlineIcon),
    //             ],
    //           ),
    //         ),
    //         labelText(
    //           title,
    //           fontSize: 20,
    //           fontWeight: FontWeight.w500,
    //           color: WHITE,
    //           // maxLine: 1,
    //         ),
    //         GestureDetector(
    //           onTap: onTap,
    //           child: Wrap(
    //             spacing: 5,
    //             crossAxisAlignment: WrapCrossAlignment.center,
    //             children: [
    //               labelText(
    //                 "Learn more",
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w500,
    //                 color: WHITE,
    //               ),
    //               const Icon(
    //                 Icons.arrow_forward,
    //                 color: WHITE,
    //                 size: 20,
    //               ),
    //             ],
    //           ),
    //         ),
    //         ySpace(height: 24),
    //       ],
    //     ),
    //   ),
    // );
  }
}
