import 'package:nodes/features/dashboard/components/card_template.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/enums.dart';
import 'package:nodes/utilities/widgets/shimmer_loader.dart';

class HorizontalSlidingCards extends StatefulWidget {
  const HorizontalSlidingCards({
    super.key,
    required this.dataSource,
  });
  final HorizontalSlidingCardDataSource dataSource;

  @override
  State<HorizontalSlidingCards> createState() => _HorizontalSlidingCardsState();
}

class _HorizontalSlidingCardsState extends State<HorizontalSlidingCards> {
  Future<List<String>> getData() async {
    // get the type of call, from widge...then call using the controller...
    // The type also contols the onTap function and all...
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
    return FutureBuilder<List<String>>(
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
            height: 240,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return CustomCardTemplate(
                      imgUrl:
                          "https://thumbs.dreamstime.com/z/letter-o-blue-fire-flames-black-letter-o-blue-fire-flames-black-isolated-background-realistic-fire-effect-sparks-part-157762935.jpg",
                      title: "Lorem ipsum dolor sit amet, con...",
                      onTap: () {},
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
}
