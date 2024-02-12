import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';

class SubmitBtn extends StatelessWidget {
  final Widget title;
  final Widget? image;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPressed;
  final bool loading;
  final bool withIcon;
  final bool isEnabled;
  final String? loadingTxt;
  final Color? color;
  final double height;

  const SubmitBtn({
    Key? key,
    required this.onPressed,
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.color,
    this.image,
    this.loading = false,
    this.withIcon = false,
    this.loadingTxt,
    this.isEnabled = true,
    this.height = 51,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 51,
      height: height,
      child: loading
          ? ElevatedButton.icon(
              icon: const Loader(),
              onPressed: null,
              label: btnTxt(loadingTxt ?? ''),
              style: ElevatedButton.styleFrom(
                onSurface: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            )
          : Stack(
              children: [
                ElevatedButton(
                  onPressed: isEnabled ? onPressed : null,
                  style: ElevatedButton.styleFrom(
                    primary: color ?? PRIMARY,
                    padding: const EdgeInsets.all(14.0),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!isObjectEmpty(leftIcon))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: leftIcon,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: title,
                      ),
                      if (!isObjectEmpty(rightIcon))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: rightIcon,
                        ),
                    ],
                  ),
                ),
                if (withIcon)
                  Positioned(
                    bottom: 6,
                    top: 1,
                    left: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(14.0),
                      child: image ??
                          const Icon(
                            Icons.mail_rounded,
                            color: PRIMARY,
                          ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class FlatBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget title;
  final bool loading;
  final Color? color;
  final double width;
  final double height;
  final BorderRadius radius;

  const FlatBtn(
      {Key? key,
      @required this.onPressed,
      @required required this.title,
      this.loading = false,
      this.color,
      this.radius = BorderRadius.zero,
      this.height = 54,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: loading
          ? const Loader()
          : TextButton(
              onPressed: onPressed,
              child: title,
              style: TextButton.styleFrom(
                backgroundColor: color ?? Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: radius,
                ),
              ),
            ),
    );
  }
}

class OutlineBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool loading;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final double? width;
  final double borderRadius;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? color;
  final double height;

  const OutlineBtn({
    Key? key,
    @required this.onPressed,
    required this.child,
    this.loading = false,
    this.width,
    this.leftIcon,
    this.rightIcon,
    this.color,
    this.borderRadius = 8,
    this.height = 54,
    this.borderColor,
    this.foregroundColor = PRIMARY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: borderColor ?? Colors.white,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        // child: loading == false ? child : const Loader(),
        child: loading == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isObjectEmpty(leftIcon))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: leftIcon,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: child,
                  ),
                  if (!isObjectEmpty(rightIcon))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: rightIcon,
                    ),
                ],
              )
            : const Loader(),
      ),
    );
  }
}

Text btnTxt(String title, [Color? color, double? fontSize]) {
  return subtext(
    title,
    color: color ?? BLACK,
    fontWeight: FontWeight.w400,
    fontSize: fontSize ?? 16,
  );
}
