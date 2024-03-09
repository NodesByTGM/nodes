import 'package:dotted_border/dotted_border.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      padding: EdgeInsets.all(padding ?? 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: WHITE,
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 4),
            color: GRAY.withOpacity(0.4),
            blurRadius: 4,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            offset: const Offset(-2, -2),
            color: GRAY.withOpacity(0.4),
            blurRadius: 4,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: child,
    );
  }
}

class CustomDottedBorder extends StatelessWidget {
  const CustomDottedBorder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: DOTTED_BORDER,
      strokeWidth: 0.7,
      borderType: BorderType.RRect,
      dashPattern: const <double>[8, 8],
      padding: const EdgeInsets.all(16),
      radius: const Radius.circular(8),
      child: child,
    );
  }
}
