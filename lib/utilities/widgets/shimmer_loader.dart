import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    Key? key,
    this.marginRight = 5,
    this.marginBottom = 0,
    this.height = 200,
    this.nums = 5,
    this.width,
    this.baseColor,
    this.highlightColor,
    this.scrollDirection,
  }) : super(key: key);

  final double marginRight;
  final double marginBottom;
  final double height;
  final int nums;
  final double? width;
  final Color? baseColor;
  final Color? highlightColor;
  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection ?? Axis.horizontal,
      child: scrollDirection == Axis.vertical ? Column(
        children: _content(context)
      ) : Row(
        children: _content(context)
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    return List.generate(
        nums,
        (index) => Shimmer.fromColors(
          baseColor: baseColor ?? Colors.grey.shade300,
          highlightColor: highlightColor ?? Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.only(
              right: marginRight,
              bottom: marginBottom,
            ),
            width: width ?? screenWidth(context) * 0.6,
            height: height,
            decoration: const BoxDecoration(
              color: BORDER,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
      );
  }
}
