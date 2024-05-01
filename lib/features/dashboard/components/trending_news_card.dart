// ignore_for_file: file_names, deprecated_member_use
import 'package:nodes/features/dashboard/components/trending_news_detail.dart';
import 'package:nodes/features/dashboard/model/trending_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TrendingNewsCard extends StatefulWidget {
  const TrendingNewsCard({
    super.key,
    required this.news,
  });

  final TrendingNewsModel news;

  @override
  State<TrendingNewsCard> createState() => _TrendingNewsCardState();
}

class _TrendingNewsCardState extends State<TrendingNewsCard> {
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
              // Add an overlay on this image please...
              child: cachedNetworkImage(
                imgUrl: "${widget.news.urlToImage}",
                size: screenWidth(context),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      widget.news.title ?? "",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: WHITE,
                      maxLine: 1,
                    ),
                    ySpace(height: 8),
                    subtext(
                      "${shortDate(widget.news.publishedAt ?? DateTime.now())}, ${widget.news.author ?? ""}",
                      color: WHITE,
                      fontSize: 14,
                    ),
                    ySpace(height: 24),
                    Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: WHITE,
                        ),
                        subtext(
                          // "Lagos | Nigeria",
                          "${widget.news.source?.name}",
                          color: WHITE.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                // ySpace(height: 40),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      showTrendingNewsDetailsBottomSheet(context, widget.news);
                    },
                    child: labelText(
                      "View details",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: WHITE,
                    ),
                  ),
                ),
                ySpace(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showTrendingNewsDetailsBottomSheet(
    BuildContext context,
    TrendingNewsModel news,
  ) {
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BottomSheetWrapper(
              closeOnTap: true,
              title: labelText(
                "${news.title}",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              child: TrendingNewsDetail(
                news: news,
              ),
            );
          },
        );
      },
    );
  }
}
