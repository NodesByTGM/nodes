import 'package:nodes/utilities/constants/exported_packages.dart';

class SuccessView extends StatelessWidget {
  static const String routeName = '/success';
  final SuccessData? successData;

  const SuccessView({Key? key, this.successData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isEmpty(successData?.route)
            ? navigateBack(context)
            : navigateAndClearPrev(context, successData!.route!);
        return false;
      },
      child: Scaffold(
        backgroundColor: WHITE,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                labelText(
                  successData?.title ?? "Successful!!!",
                  fontSize: 24,
                ),
                ySpace(height: 24),
                SvgPicture.asset(successData?.image ?? ImageUtils.success),
                ySpace(height: 10),
                Visibility(
                  visible: isNotEmpty(successData?.description),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: subtext(
                      '${successData?.description}',
                      textAlign: TextAlign.center,
                      fontSize: 12,
                    ),
                  ),
                ),
                ySpace(height: 20),
                if (isNotEmpty(successData?.btnText))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: SubmitBtn(
                      onPressed: () => isEmpty(successData?.route)
                          ? navigateBack(context)
                          : navigateAndClearPrev(context, successData!.route!),
                      title: btnTxt(
                          successData?.btnText ?? Constants.continueText),
                      color: PRIMARY,
                    ),
                  ),
                if (!isObjectEmpty(successData?.customBtn))
                  GestureDetector(
                    onTap: () => isEmpty(successData?.route)
                        ? navigateBack(context)
                        : navigateAndClearPrev(context, successData!.route!),
                    child: successData?.customBtn,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessData {
  final String? title;
  final String? description;
  final String? route;
  final String? image;
  final String? btnText;
  final Widget? customBtn;

  SuccessData({
    this.title,
    this.description,
    this.route,
    this.image,
    this.btnText,
    this.customBtn,
  });
}
