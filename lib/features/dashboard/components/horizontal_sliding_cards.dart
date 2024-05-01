import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/dashboard/components/card_template.dart';
import 'package:nodes/features/dashboard/components/community_card_template.dart';
import 'package:nodes/features/dashboard/components/leave_a_rating.dart';
import 'package:nodes/features/dashboard/components/top_movies_card_template.dart';
import 'package:nodes/features/dashboard/model/movie_show_model.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class HorizontalSlidingCards extends StatefulWidget {
  const HorizontalSlidingCards({
    super.key,
    required this.dataSource,
    this.height,
  });
  final HorizontalSlidingCardDataSource dataSource;
  final double? height;

  @override
  State<HorizontalSlidingCards> createState() => _HorizontalSlidingCardsState();
}

class _HorizontalSlidingCardsState extends State<HorizontalSlidingCards> {
  late DashboardController dashCtrl;

  @override
  void initState() {
    dashCtrl = locator.get<DashboardController>();
    super.initState();
  }

  Future<List<dynamic>> getData() async {
    // get the type of call, from widge...then call using the controller...
    // The type also contols the onTap function and all...
    switch (widget.dataSource) {
      case HorizontalSlidingCardDataSource.TopMovies:
        List<dynamic> data = (await dashCtrl.fetchMovieShows(context)) ?? [];
        return data;
      default:
    }
    await Future.delayed(const Duration(seconds: 5));
    return [
      "I'm Ramy",
      "I'm Yasser",
      "I'm Ahmed",
      "I'm Yossif",
      "I'm Ramy",
      "I'm Yasser",
      "I'm Ahmed",
      "I'm Yossif",
      "I'm Ramy",
      "I'm Yasser",
      "I'm Ahmed",
      "I'm Yossif",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerLoader();
        } else if (snapshot.hasError) {
          // Use a proper error widget with a Reload feature...
          return Container(
            margin: const EdgeInsets.only(right: 5),
            width: screenWidth(context),
            height: 200,
            decoration: const BoxDecoration(
              color: BORDER,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Center(
              child: labelText("Oops!!!! Error"),
            ),
          );
        } else if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            // height: 240,
            height: widget.height ?? 240,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    dynamic data = snapshot.data;
                    // Depending on the datasource, the corresponding cards will be used...
                    return designatedCardDisplay(
                      // pass the data here... and receive it as dynamic, then format it using the help of the source...
                      data,
                    );
                  },
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator.adaptive();
      },
    );
  }

  designatedCardDisplay(dynamic data) {
    switch (widget.dataSource) {
      case HorizontalSlidingCardDataSource.TopMovies:
        MovieShowModel movieShow = data as MovieShowModel;
        return TopMovieCardTemplate(
          imgUrl: "${movieShow.backdrop_path}",
          title: (movieShow.original_name ?? movieShow.original_title) ?? "",
          rating: movieShow.vote_average ?? 0,
          onTap: showRatingBottomSheet,
          ratingTap: showRatingBottomSheet,
          // ratingTap: () {
          //   showRatingBottomSheet();
          // },
        );
      case HorizontalSlidingCardDataSource.Community:
        return CommunityCardTemplate(
          imgUrl:
              "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
          title: "Lorem ipsum dolor sit amet, con...",
          onTap: () {},
        );
      case HorizontalSlidingCardDataSource.Recommended:
        return CommunitySpaceCardTemplate(
          imgUrl:
              "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
          title: "Lorem ipsum dolor sit amet, con...",
          height: 300,
          width: screenWidth(context) * 0.75,
          onTap: () {
            context
                .read<NavController>()
                .updatePageListStack(SpaceDetailsScreen.routeName);
          },
        );
      default:
        return CustomCardTemplate(
          imgUrl:
              "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
          title: "Lorem ipsum dolor sit amet, con...",
          onTap: () {},
        );
    }
  }

  showRatingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      backgroundColor: WHITE,
      elevation: 0.0,
      builder: (context) {
        return BottomSheetWrapper(
          closeOnTap: true,
          title: labelText(
            "Leave a rating",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          child: const LeaveARating(),
        );
      },
    );
  }
}
