import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/dashboard/components/card_template.dart';
import 'package:nodes/features/dashboard/screen/individual/individual_dashboard_single_item_details.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class IndividualDashboardViewAllDynamicScreen extends StatefulWidget {
  const IndividualDashboardViewAllDynamicScreen({super.key});
  static const String routeName = "/individual_dashboard_view_all_dynamic_screen";
  
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

  @override
  void initState() {
    selectedFilter = filterOptions.first;
    selectedSort = sortOptions.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // will be using another controller instead of auth, for making the API calls...
    return Consumer2<NavController, AuthController>(
      builder: (context, navCtrl, authCtrl, _) {
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
                    "Top Movies",
                    fontSize: 12,
                  ),
                ],
              ),
              ySpace(height: 40),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: GRAY,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: const AssetImage(ImageUtils.appIcon),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.multiply,
                    ),
                  ),
                ),
                child: Center(
                  child: labelText(
                    "Top Movies",
                    color: WHITE,
                    fontSize: 20,
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
              if (1 > 2) ...[
                ShimmerLoader(
                  scrollDirection: Axis.vertical,
                  width: screenWidth(context),
                  marginBottom: 10,
                ),
              ],
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: 5,
                itemBuilder: (context, i) {
                  return CustomCardTemplate(
                    imgUrl:
                        "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
                    title: "Lorem ipsum dolor sit amet, con...",
                    onTap: () {
                      navCtrl.updatePageListStack(
                        IndividualDashboardSingleItemDetailsScreen.routeName,
                      );
                    },
                    height: 240,
                  );
                },
                separatorBuilder: (context, i) => ySpace(height: 10),
              ),
              ySpace(height: 20),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      int _ = index + 1;
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.only(
                            right: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: BORDER),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: labelText("$_"),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
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
