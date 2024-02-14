import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class LeaveARating extends StatefulWidget {
  const LeaveARating({super.key});

  @override
  State<LeaveARating> createState() => _LeaveARatingState();
}

class _LeaveARatingState extends State<LeaveARating> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ySpace(),
        labelText(
          "Lorem ipsum dolor sit amet.",
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 32),
        RatingBar(
          initialRating: 0,
          direction: Axis.horizontal,
          minRating: 1,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: SvgPicture.asset(ImageUtils.starIcon),
            half: SvgPicture.asset(
              ImageUtils.starOutlineIcon,
              color: BLACK,
            ),
            empty: SvgPicture.asset(
              ImageUtils.starOutlineIcon,
              color: BLACK,
            ),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 10),
          onRatingUpdate: (rating) {
            // print(rating);
          },
        ),
        ySpace(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(context) / 4),
          child: SubmitBtn(
            onPressed: () {
              navigateBack(context);
            },
            title: btnTxt(
              "Rate",
              WHITE,
            ),
          ),
        ),
      ],
    );
  }
}
