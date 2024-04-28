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
      child: scrollDirection == Axis.vertical
          ? Column(children: _content(context))
          : Row(children: _content(context)),
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

class ProfileShimmerLoader extends StatelessWidget {
  const ProfileShimmerLoader({super.key, this.isPadded = true});

  final bool isPadded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isPadded ? screenPadding : null,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: shimmer(
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              xSpace(),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shimmer(
                      child: Container(
                        color: WHITE,
                        height: 10,
                        width: screenWidth(context),
                      ),
                    ),
                    ySpace(height: 10),
                    shimmer(
                      child: Container(
                        color: WHITE,
                        height: 10,
                        width: 100,
                      ),
                    ),
                    ySpace(height: 10),
                    shimmer(
                      child: Container(
                        color: WHITE,
                        height: 10,
                        width: 70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ySpace(height: 20),
          shimmer(
            child: Container(
              height: 100,
              width: screenWidth(context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: WHITE,
              ),
            ),
          ),
          ySpace(height: 20),
          shimmer(
            child: Container(
              color: WHITE,
              margin: screenPadding,
              height: 50,
              width: screenWidth(context),
            ),
          ),
          ySpace(height: 20),
          shimmer(
            child: Container(
              height: 100,
              width: screenWidth(context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: WHITE,
              ),
            ),
          ),
          ySpace(height: 20),
          Row(
            children: [
              shimmer(
                child: Container(
                  color: WHITE,
                  height: 30,
                  width: 100,
                ),
              ),
              xSpace(width: 10),
              shimmer(
                child: Container(
                  color: WHITE,
                  height: 30,
                  width: 100,
                ),
              ),
            ],
          ),
          ySpace(height: 10),
          shimmer(
            child: Container(
              height: 300,
              width: screenWidth(context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: WHITE,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}

class BoxShimmerLoader extends StatelessWidget {
  const BoxShimmerLoader({
    Key? key,
    this.height = 200,
    this.width,
  }) : super(key: key);

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width ?? screenWidth(context) * 0.6,
        height: height,
        decoration: const BoxDecoration(
          color: BORDER,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
