import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/dashboard/components/card_template.dart';
import 'package:nodes/features/dashboard/components/cms_content_card_template.dart';
import 'package:nodes/features/dashboard/components/top_movies_card_template.dart';
import 'package:nodes/features/dashboard/model/dynamic_cms_content_model.dart';
import 'package:nodes/features/dashboard/model/movie_show_model.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_single_item_details.dart';
import 'package:nodes/features/dashboard/view_model/dashboard_controller.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class IndividualDashboardViewAllDynamicScreen extends StatefulWidget {
  const IndividualDashboardViewAllDynamicScreen({super.key});
  static const String routeName =
      "/individual_dashboard_view_all_dynamic_screen";
  @override
  State<IndividualDashboardViewAllDynamicScreen> createState() =>
      _IndividualDashboardViewAllDynamicScreenState();
}

class _IndividualDashboardViewAllDynamicScreenState
    extends State<IndividualDashboardViewAllDynamicScreen> {
  late String selectedFilter;
  late String selectedSort;
  List<String> filterOptions = ['All', 'some'];
  List<String> sortOptions = ['Latest', 'Trending', 'Classic'];

  late HorizontalSlidingCardDataSource currentSource;

  @override
  void initState() {
    selectedFilter = filterOptions.first;
    selectedSort = sortOptions.first;
    currentSource = locator.get<NavController>().currentDashboardDynamicItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // will be using another controller instead of auth, for making the API calls...
    return Consumer2<NavController, DashboardController>(
      builder: (context, navCtrl, dashCtrl, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ySpace(height: 40),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      navCtrl.popPageListStack();
                    },
                    child: subtext(
                      "Home",
                      fontSize: 12,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: BORDER,
                  ),
                  labelText(
                    getHorizontalSlidingCardDataSourceTitle(currentSource),
                    fontSize: 12,
                  ),
                ],
              ),
              ySpace(height: 40),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: WHITE,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: const AssetImage(ImageUtils.cmsBg),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      // Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.2),
                      BlendMode.multiply,
                    ),
                  ),
                ),
                child: Center(
                  child: labelText(
                    getHorizontalSlidingCardDataSourceTitle(currentSource),
                    color: BLACK,
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ySpace(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterSortControls(
                    type: FilterSort.Filter,
                    activeOption: selectedFilter,
                    options: filterOptions,
                    onSelected: (val) {
                      setState(() {
                        selectedFilter = val;
                      });
                    },
                  ),
                  FilterSortControls(
                    type: FilterSort.Sort,
                    activeOption: selectedSort,
                    options: sortOptions,
                    onSelected: (val) {
                      setState(() {
                        selectedSort = val;
                      });
                    },
                  ),
                ],
              ),
              ySpace(height: 20),
              customDivider(),
              // if (1 < 2) ...[
              //   ShimmerLoader(
              //     scrollDirection: Axis.vertical,
              //     width: screenWidth(context),
              //     marginBottom: 10,
              //   ),
              // ],
              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   padding: const EdgeInsets.all(0),
              //   itemCount: 5,
              //   itemBuilder: (context, i) {
              //     return SizedBox(
              //       height: 300,
              //       child: CMSCardTemplate(
              //         imgUrl:
              //             "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
              //         title: "Lorem ipsum dolor sit amet, con...",
              //         description: "Lorem ipsum dolor sit amet, con...",
              //         onTap: () {
              //           navCtrl.updatePageListStack(
              //             IndividualDashboardSingleItemDetailsScreen.routeName,
              //           );
              //         },
              //         height: 240,
              //       ),
              //     );
              //   },
              //   separatorBuilder: (context, i) => ySpace(height: 10),
              // ),
              FutureBuilder<List<dynamic>>(
                future: getHorizontalSlidingCardData(
                  context,
                  source: currentSource,
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
                    return const ShimmerLoader(scrollDirection: Axis.vertical);
                  } else if (snapshot.hasError) {
                    // Use a proper error widget with a Reload feature...
                    return box("Oops!!!! Error");
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    if (isObjectEmpty(snapshot.data)) {
                      return box("Oops!!! Please check back later...");
                    }
                    // return SizedBox(
                    //   height: 240,
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Row(
                    //       children: List.generate(
                    //         snapshot.data!.length,
                    //         (index) {
                    //           dynamic datum = snapshot.data![index];
                    //           // Depending on the datasource, the corresponding cards will be used...
                    //           return designatedCardDisplay(
                    //             // pass the data here... and receive it as dynamic, then format it using the help of the source...
                    //             datum,
                    //             data: snapshot.data,
                    //             // Passing all the data here,since i'm not storing it in the controller...
                    //             dashCtrl: dashCtrl,
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // );
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (c, i) {
                        dynamic datum = snapshot.data![i];
                        return designatedCardDisplay(
                          datum,
                          data: snapshot.data,
                          dashCtrl: dashCtrl,
                        );
                      },
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  designatedCardDisplay(
    dynamic datum, {
    List<dynamic>? data,
    required DashboardController dashCtrl,
  }) {
    switch (currentSource) {
      case HorizontalSlidingCardDataSource.TopMovies:
        MovieShowModel movieShow = datum as MovieShowModel;
        return TopMovieCardTemplate(
          imgUrl: "${movieShow.backdrop_path}",
          title: (movieShow.original_name ?? movieShow.original_title) ?? "",
          rating: movieShow.vote_average ?? 0,
          onTap: () => showRatingBottomSheet(context),
          ratingTap: () => showRatingBottomSheet(context),
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

class FilterSortControls extends StatelessWidget {
  const FilterSortControls({
    super.key,
    required this.type,
    required this.options,
    required this.activeOption,
    required this.onSelected,
  });

  final FilterSort type;
  final List<String> options;
  final String activeOption;
  final Function(dynamic val) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: [
        labelText(
          "${enumToString(type).toUpperCase()} BY",
          fontSize: 12,
        ),
        PopupMenuButton<String>(
          onSelected: (value) => onSelected(value),
          itemBuilder: (context) {
            return getOptions(activeOption);
          },
          offset: const Offset(0, 40),
          color: WHITE,
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: 10,
              right: 2,
            ),
            decoration: BoxDecoration(
              color: WHITE,
              border: Border.all(width: 0.7, color: BORDER),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                labelText(
                  activeOption,
                  color: GRAY,
                ),
                const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: BORDER,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<PopupMenuEntry<String>> getOptions(String ac) {
    List<PopupMenuEntry<String>> _ = [];
    for (var o in options) {
      _.add(PopupMenuItem(
        value: o,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subtext(o),
            if (ac == o) ...[
              const Icon(
                Icons.check,
                color: PRIMARY,
              ),
            ],
          ],
        ),
      ));
    }

    return _;
  }
}
