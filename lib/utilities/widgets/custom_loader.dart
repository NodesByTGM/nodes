import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinKit = SpinKitDualRing(
      color: PRIMARY,
      size: 25.0,
      lineWidth: 3,
      duration: Duration(milliseconds: 400),
    );
    return const Center(
      child: spinKit,
    );
  }
}

// class DataLoader extends StatelessWidget {
//   const DataLoader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Lottie.asset(ImageUtils.kwikaccessLoader, height: 60),
//     );
//   }
// }

class HeartLoader extends StatelessWidget {
  const HeartLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinKit = SpinKitPumpingHeart(
      color: PRIMARY,
      size: 24.0,
    );

    return const Center(
      child: spinKit,
    );
  }
}

class SaveIconLoader extends StatelessWidget {
  const SaveIconLoader({Key? key, this.color = PRIMARY}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    var spinKit = SpinKitSquareCircle(
      color: color,
      size: 24.0,
    );

    return Center(
      child: spinKit,
    );
  }
}

class ImageLoader extends StatelessWidget {
  final double size;

  const ImageLoader({Key? key, this.size = 30.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spinKit = SpinKitRipple(
      color: PRIMARY,
      size: size,
    );

    return Center(
      child: spinKit,
    );
  }
}

class EmptyState extends StatelessWidget {
  final String label;
  final String description;
  final String? image;
  final List<Widget> children;
  final bool isImage;

  const EmptyState({
    Key? key,
    required this.label,
    this.description = "",
    this.isImage = false,
    this.image = ImageUtils.emptySvg,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (!isImage)
          SvgPicture.asset(
            image!,
            height: 100,
          ),
        if (isImage)
          Image.asset(
            image!,
            height: 100,
          ),
        ySpace(),
        SizedBox(
          width: screenWidth(context) * .5,
          child: labelText(
            label,
            color: PRIMARY,
            textAlign: TextAlign.center,
            fontSize: 14,
          ),
        ),
        ySpace(height: 10),
        if (isNotEmpty(description))
          SizedBox(
            width: screenWidth(context) - 100,
            child: subtext(
              description,
              textAlign: TextAlign.center,
              fontSize: 12,
              color: FORM_TEXT,
            ),
          ),
        if (children.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          )
        else
          const SizedBox()
      ],
    );
  }
}

class DataReload extends StatelessWidget {
  final VoidCallback onTap;
  final bool isEmpty;
  final bool isLoading;
  final bool isSearch;
  final double? maxHeight;
  final String? label;
  final Widget? loader;

  const DataReload({
    Key? key,
    this.label,
    required this.onTap,
    this.isEmpty = false,
    this.isLoading = false,
    this.isSearch = false,
    this.maxHeight,
    this.loader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE,
      constraints: BoxConstraints(minHeight: maxHeight ?? 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (isLoading) Expanded(child: loader ?? const PickListLoader()),
          if (isLoading) Expanded(child: loader ?? const Loader()),
          if (isEmpty && !isLoading && isSearch)
            const EmptyState(
              label: 'No result found',
              description: '',
            ),
          if (isEmpty && !isLoading && !isSearch)
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    subtext(label ?? "Oops! Unable to fetch Data. ",
                        fontSize: 14),
                    // horizontalSpace(width: 10),
                    TextButton.icon(
                        onPressed: onTap,
                        icon: const Icon(
                          Icons.autorenew_rounded,
                          size: 12,
                          color: LIGHT_BLUE,
                        ),
                        label: subtext("Reload", color: LIGHT_BLUE))
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
