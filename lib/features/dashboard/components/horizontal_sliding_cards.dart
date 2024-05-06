// ignore_for_file: use_build_context_synchronously

import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/community/components/community_space_card_template.dart';
import 'package:nodes/features/community/screens/space_details_screen.dart';
import 'package:nodes/features/dashboard/components/card_template.dart';
import 'package:nodes/features/dashboard/components/cms_content_card_template.dart';
import 'package:nodes/features/dashboard/components/leave_a_rating.dart';
import 'package:nodes/features/dashboard/components/top_movies_card_template.dart';
import 'package:nodes/features/dashboard/model/dynamic_cms_content_model.dart';
import 'package:nodes/features/dashboard/model/movie_show_model.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_single_item_details.dart';
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

  // Future<List<dynamic>> getData() async {
  //   // get the type of call, from widge...then call using the controller...
  //   // The type also contols the onTap function and all...
  //   switch (widget.dataSource) {
  //     case HorizontalSlidingCardDataSource.TopMovies:
  //       List<dynamic> data = (await dashCtrl.fetchMovieShows(context)) ?? [];
  //       return data;
  //     case HorizontalSlidingCardDataSource.Birthdays:
  //       List<dynamic> data = (await dashCtrl.fetchCMSContent(
  //             context,
  //             type: HorizontalSlidingCardDataSource.Birthdays,
  //           )) ??
  //           [];
  //       return data;
  //     case HorizontalSlidingCardDataSource.Flashbacks:
  //       List<dynamic> data = (await dashCtrl.fetchCMSContent(
  //             context,
  //             type: HorizontalSlidingCardDataSource.Flashbacks,
  //           )) ??
  //           [];
  //       return data;
  //     case HorizontalSlidingCardDataSource.CollaborationSpotlights:
  //       List<dynamic> data = (await dashCtrl.fetchCMSContent(
  //             context,
  //             type: HorizontalSlidingCardDataSource.CollaborationSpotlights,
  //           )) ??
  //           [];
  //       return data;
  //     case HorizontalSlidingCardDataSource.HiddenGems:
  //       List<dynamic> data = (await dashCtrl.fetchCMSContent(
  //             context,
  //             type: HorizontalSlidingCardDataSource.HiddenGems,
  //           )) ??
  //           [];
  //       return data;
  //     default:
  //   }
  //   await Future.delayed(const Duration(seconds: 5));
  //   return [
  //     "I'm Ramy",
  //     "I'm Yasser",
  //     "I'm Ahmed",
  //     "I'm Yossif",
  //     "I'm Ramy",
  //     "I'm Yasser",
  //     "I'm Ahmed",
  //     "I'm Yossif",
  //     "I'm Ramy",
  //     "I'm Yasser",
  //     "I'm Ahmed",
  //     "I'm Yossif",
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      // future: getData(),
      future: getHorizontalSlidingCardData(
        context,
        source: widget.dataSource,
        dashCtrl: dashCtrl,
      ),
      builder: (context, snapshot) {
        Container box(String text) => Container(
              margin: const EdgeInsets.only(right: 5),
              width: screenWidth(context),
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageUtils.spaceEmptyIcon,
                    height: 150,
                  ),
                  ySpace(height: 4),
                  subtext(text),
                ],
              ),
            );
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerLoader();
        } else if (snapshot.hasError) {
          // Use a proper error widget with a Reload feature...
          return box("Oops!!!! Error");
        } else if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (isObjectEmpty(snapshot.data)) {
            return box("Oops!!! Please check back later...");
          }
          return SizedBox(
            height: widget.height ?? 240,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    dynamic datum = snapshot.data![index];
                    // Depending on the datasource, the corresponding cards will be used...
                    return designatedCardDisplay(
                      // pass the data here... and receive it as dynamic, then format it using the help of the source...
                      datum,
                      data: snapshot.data,
                      // Passing all the data here,since i'm not storing it in the controller...
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

  designatedCardDisplay(dynamic datum, {List<dynamic>? data}) {
    switch (widget.dataSource) {
      case HorizontalSlidingCardDataSource.TopMovies:
        MovieShowModel movieShow = datum as MovieShowModel;
        return TopMovieCardTemplate(
          imgUrl: "${movieShow.backdrop_path}",
          title: (movieShow.original_name ?? movieShow.original_title) ?? "",
          rating: movieShow.vote_average ?? 0,
          onTap: () =>
              showRatingBottomSheet(context), // will add the movie item soon..
          ratingTap: () =>
              showRatingBottomSheet(context), // will add the movie item soon..
          // ratingTap: () {
          //   showRatingBottomSheet();
          // },
        );
      case HorizontalSlidingCardDataSource.Birthdays:
      case HorizontalSlidingCardDataSource.HiddenGems:
      case HorizontalSlidingCardDataSource.CollaborationSpotlights:
      case HorizontalSlidingCardDataSource.Flashbacks:
        DynamicCMSContentModel cmsContent = datum as DynamicCMSContentModel;
        return CMSCardTemplate(
          imgUrl: "${cmsContent.thumbnail?.url}",
          title: "${cmsContent.title}",
          description: "${cmsContent.description}",
          onTap: () {
            // First Pass the datum as the currentlyViewed before sending it here...
            // Also, pass the full data too, as it'll be used in the individual descriptiong page
            dashCtrl.setCurrentlyViewedDynamicCMSContents(
              data: datum,
              dataList: data as List<DynamicCMSContentModel>,
            );
            context.read<NavController>().updatePageListStack(
                  IndividualDashboardSingleItemDetailsScreen.routeName,
                );
          },
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
}
