// ignore_for_file: file_names

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nodes/features/dashboard/model/trending_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class TrendingNewsDetail extends StatefulWidget {
  const TrendingNewsDetail({
    super.key,
    required this.news,
  });

  final TrendingNewsModel news;

  @override
  State<TrendingNewsDetail> createState() => _TrendingNewsDetailState();
}

class _TrendingNewsDetailState extends State<TrendingNewsDetail> {
  late TrendingNewsModel news;

  @override
  void initState() {
    news = widget.news;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (!isObjectEmpty(news.urlToImage)) ...[
          SizedBox(
            height: 250,
            child: cachedNetworkImage(
              imgUrl: "${news.urlToImage}",
              size: screenWidth(context),
            ),
          ),
        ],
        ySpace(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoItem(
                icon: ImageUtils.mapMarkerOutlineIcon,
                title: capitalize("${widget.news.source?.name}"),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.clockOutlineIcon,
                // title: fromDatTimeToTimeOfDay(news.eventTime ?? DateTime.now()),
                title: fromDatTimeToTimeOfDay(
                  widget.news.publishedAt ?? DateTime.now(),
                ),
              ),
              ySpace(height: 19),
              infoItem(
                icon: ImageUtils.calendarOutlineIcon,
                title: shortDate(widget.news.publishedAt ?? DateTime.now()),
              ),
              // ySpace(height: 19),
              // infoItem(
              //   icon: ImageUtils.cardOutlineIcon,
              //   // title: "Free",
              //   title: capitalize("${news.paymentType}"),
              // ),
              // ySpace(height: 19),
            ],
          ),
        ),
        ySpace(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.7,
              color: BORDER,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                "Other details",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ySpace(height: 24),
              labelText(
                news.title ?? "",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: GRAY,
              ),
              ySpace(height: 10),
              subtext(
                news.description ?? "",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ],
          ),
        ),
        ySpace(height: 24),
        SubmitBtn(
          onPressed: () {
            customUrlLauncher(
              context,
              type: "web",
              url: "${news.url}",
            );
          },
          rightIcon: Icon(
            MdiIcons.arrowTopRight,
            color: WHITE,
          ),
          title: btnTxt(
            "Continue Reading",
            WHITE,
          ),
        ),
      ],
    );
  }

  Wrap infoItem({
    required String icon,
    required String title,
  }) {
    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SvgPicture.asset(icon),
        labelText(
          title,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
