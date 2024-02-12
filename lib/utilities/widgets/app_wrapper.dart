import 'package:nodes/utilities/constants/exported_packages.dart';

class AppWrapper extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool isCancel;
  final bool appBarBottomBorder;
  final bool safeBottom;
  final bool hasBar;
  final bool centerTitle;
  final double? leadingWidth;
  final GestureTapCallback? onTap;
  final Color? backBtnColor;
  final Key? scafoldKey;

  const AppWrapper({
    Key? key,
    this.actions,
    required this.body,
    this.title,
    this.safeBottom = true,
    this.hasBar = false,
    this.centerTitle = true,
    this.leading,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.padding,
    this.leadingWidth,
    this.onTap,
    this.isCancel = true,
    this.appBarBottomBorder = true,
    this.backBtnColor = BLACK,
    this.scafoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: 0,
        title: title,
        shape: appBarBottomBorder
            ? const RoundedRectangleBorder(
                side: BorderSide(color: BLACK, width: 0.2),
              )
            : null,
        centerTitle: centerTitle,
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        leading: !isObjectEmpty(leading)
            ? leading
            : Visibility(
                visible: !isCancel,
                child: GestureDetector(
                  onTap: onTap ?? () => Navigator.pop(context),
                  child: Padding(
                    padding: hasBar
                        ? const EdgeInsets.only(top: 30.0)
                        : const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      ImageUtils.back,
                      color: backBtnColor,
                    ),
                  ),
                ),
              ),
        leadingWidth: leadingWidth,
        actions: (!isCancel)
            ? actions
            : [
                Visibility(
                  visible: isCancel,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(ImageUtils.cancel),
                    ),
                  ),
                ),
              ],
      ),
      body: SafeArea(
        bottom: safeBottom,
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          padding: padding ?? screenPadding,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: body,
          ),
        ),
      ),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
    );
  }
}

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;
  final bool closeOnTap;
  final Widget? title;
  final Color? backgroundColor;

  const BottomSheetWrapper({
    Key? key,
    required this.child,
    this.closeOnTap = true,
    this.title,
    this.backgroundColor = WHITE,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenWidth(context),
          constraints: BoxConstraints(
            maxHeight: screenHeight(context) * .85,
          ),
          color: backgroundColor,
          margin: const EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 36.0,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: child,
            ),
          ),
        ),
        if (!isObjectEmpty(title))
          Positioned(
            left: 0,
            top: 16,
            child: Container(
              padding: const EdgeInsets.only(top: 16, right: 30),
              margin: const EdgeInsets.only(left: 20),
              color: WHITE,
              child: title,
            ),
          ),
        if (closeOnTap)
          Positioned(
            right: 0,
            top: 16,
            child: MaterialButton(
              highlightColor: Colors.transparent,
              onPressed: () => navigateBack(context),
              child: SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset(ImageUtils.cancel),
              ),
            ),
          ),
      ],
    );
  }
}
