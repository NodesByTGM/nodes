// ignore_for_file: constant_identifier_names, implementation_imports, prefer_generic_function_type_aliases, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bot_toast/src/toast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/utilities/widgets/custom_loader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// const FontFamily = 'br-firma';
const FontFamily = 'generalSans';

// Default Delay
Duration get screenDuration => const Duration(milliseconds: 200);

// Width of the current Screen Context
double screenWidth(context) => MediaQuery.of(context).size.width;

// Height of the current Screen Context
double screenHeight(context) => MediaQuery.of(context).size.height;

// Used to get a consistent Screen Padding
EdgeInsetsGeometry get screenPadding =>
    // const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0);
    const EdgeInsets.symmetric(horizontal: 16, vertical: 0);

// Used to give vertical Spaces
SizedBox ySpace({double? height}) {
  return SizedBox(height: height ?? 30);
}

// Used to give horizontal Spaces
SizedBox xSpace({double? width}) {
  return SizedBox(width: width ?? 30);
}

// To close input field KeyPad
closeKeyPad(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

// Time/Date Formatters

// String shortTime(DateTime now) => Jiffy.now().fromNow();
String shortTime(DateTime now) => Jiffy.parseFromDateTime(now).fromNow();
String formatDateOnly(DateTime now) => DateFormat.yMMMEd().format(now);
String formatDate(DateTime now) => DateFormat('yMd').format(now);
String fullDate(DateTime now) => DateFormat('d MMMM, y').format(now);
String shortDate(DateTime now) => DateFormat('dd MMMM, yyyy').format(now);
String registerDate(String dateTime) =>
    DateFormat("yyyy-MM-dd").parse(dateTime).toString().substring(0, 10);
// Jiffy.parseFromDateTime(DateFormat("yyyy-MM-dd").parse(dateTime)).format();
// DateFormat("yyyy-MM-dd").parse(dateTime);
String timeOfDay(TimeOfDay now) {
  return now.period == DayPeriod.pm
      ? '${now.hour - 12}:${now.minute}PM'
      : "${now.hour}:${now.minute}AM";
}

String fromDatTimeToTimeOfDay(DateTime now) {
  return timeOfDay(TimeOfDay.fromDateTime(now));
}

TimeOfDay _customStringToTimeOfDay(String s) => TimeOfDay(
    hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

String fromStringToTimeOfDay(String now) {
  // return timeOfDay(stringToTimeOfDay(now));
  return timeOfDay(_customStringToTimeOfDay(now));
}

// Routing Configs
navigateTo(BuildContext context, String route, {dynamic arguments}) {
  Navigator.pushNamed(context, route, arguments: arguments);
}

navigateAndClearAll(BuildContext context, String route,
    {String? secondRoute, dynamic arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      route, ModalRoute.withName(secondRoute ?? '/'),
      arguments: arguments);
}

navigateAndDrop(BuildContext context) {
  Navigator.of(context).popUntil(ModalRoute.withName('/'));
}

navigateBackTill(BuildContext context, {String? route}) {
  Navigator.of(context).popUntil(ModalRoute.withName(route ?? '/'));
}

navigateAndClearPrev(BuildContext context, String route, {dynamic arguments}) {
  Navigator.of(context).popAndPushNamed(route, arguments: arguments);
}

navigateBack(BuildContext context) {
  Navigator.pop(context);
}

customNavigateBack(BuildContext context) {
  context.read<NavController>().popPageListStack();
}

// Various State checkers
isEmpty(String? val) {
  return (val == null) || (val.trim().isEmpty);
}

isNotEmpty(String? val) {
  return !isEmpty(val);
}

isMap(dynamic val) {
  return (val is Map);
}

isNumber(String val) {
  return num.tryParse(val) != null;
}

isObjectEmpty(dynamic val) {
  if (val is Map) return val.isEmpty;
  if (val is List) return val.isEmpty;
  if (val is String) return isEmpty(val);
  return (val == null);
}

getObjectOrNull(dynamic val) {
  return isObjectEmpty(val) ? null : val;
}

String? trimValue(String? val) {
  return isNotEmpty(val) ? val!.trim() : null;
}

String capitalize(String s) {
  if (s.isEmpty) return '';
  List<String> names = s.trim().split(' ');
  if (names.isNotEmpty) {
    return names
        .map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');
  }
  return s;
}

String formatCurrencyAmount(String ccy, double amount) {
  return '$ccy${formatAmount(amount)}';
}

String formatAmount(double? amount) {
  if (amount == null) {
    return '';
  }
  return NumberFormat.currency(
          name: '', decimalDigits: (isInteger(amount)) ? 0 : 2)
      .format(amount);
}

String formatAmountFromInput(String val) =>
    val.split(",").join("").split(".").first;

bool isInteger(num value) => value is int || value == value.roundToDouble();

String enumToString<T>(T value, {camelCase = false}) =>
    EnumToString.convertToString(value, camelCase: camelCase);

String hyphenToUnderscore(String text) => text.split("-").join("_");
// Micro managing future function calls
safeNavigate(Function callback) {
  Future.microtask(() => callback());
}

// Notification BotToast
enum _AlertType { error, success, message }

showNotification(
    {required String message,
    required Duration duration,
    GestureTapCallback? onTap}) {
  BotToast.showSimpleNotification(
      title: message, duration: duration, onTap: onTap);
}

showText({required String message, Duration? duration}) {
  _showAlert(message, _AlertType.message, d: duration);
}

_showAlert(String message, _AlertType alert, {Duration? d}) {
  var bgColor = Colors.black.withOpacity(.9);
  var duration = d ?? const Duration(seconds: 2);

  switch (alert) {
    case _AlertType.error:
      bgColor = Colors.red;
      duration = d ?? const Duration(seconds: 3);
      break;
    case _AlertType.success:
      bgColor = Colors.green;
      break;
    default:
      break;
  }
  BotToast.showText(
    text: message,
    contentColor: bgColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    textStyle: const TextStyle(fontSize: 13.0, color: Colors.white),
    duration: duration,
  );
}

showSuccess({required String message}) {
  _showAlert(message, _AlertType.success);
}

showError({required String message, Duration? duration}) {
  _showAlert(message, _AlertType.error, d: duration);
}

// String errorMessageToString(List<String>? message) {
//   return isObjectEmpty(message)
//       ? 'Sever error occurred. Please try again later'
//       : message!.join("\n");
// }

// String errorMessageObjectToString(Map<String, dynamic>? message) {
//   if (isObjectEmpty(message)) {
//     return 'Sever error occurred. Please try again later';
//   } else {
//     var msgAarr = <String>[];
//     message?.forEach((key, value) {
//       if (value.runtimeType == String) {
//         msgAarr.add("$value");
//       } else {
//         msgAarr.add((value as List).join("\n"));
//       }
//     });
//     return msgAarr.join("\n");
//   }
// }
String errorMessageObjectToString(Map<String, dynamic>? message) {
  if (isObjectEmpty(message)) {
    return 'Sever error occurred. Please try again later';
  } else {
    var msgAarr = <String>[];
    message?.forEach((key, value) {
      if (value.runtimeType == String) {
        msgAarr.add("$value");
      } else if (value.runtimeType == bool || value.runtimeType == Null) {
      } else {
        msgAarr.add((value as List).join("\n"));
      }
    });
    return msgAarr.join("\n");
  }
}

enum DialogAction { yes, cancel }

Future<DialogAction> showAlertDialog(
  BuildContext context, {
  String? title,
  required Widget body,
  bool withButton = true,
  bool withCancel = true,
  Widget? button,
  String? cancelTitle,
  String? okTitle,
  Color okColor = PRIMARY,
  Color cancelColor = GRAY,
}) async {
  final action = await showPlatformDialog(
    context: context,
    androidBarrierDismissible: false,
    builder: (_) => BasicDialogAlert(
      title: labelText(
        title ?? "Confirmation",
        color: TITLE_COLOR,
        fontWeight: FontWeight.bold,
      ),
      content: body,
      actions: <Widget>[
        if (withCancel)
          BasicDialogAction(
            title: Text(
              cancelTitle ?? Constants.cancel,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: cancelColor,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
          ),
        BasicDialogAction(
          title: Text(
            okTitle ?? Constants.ok,
            textScaleFactor: 1.0,
            style: TextStyle(
              color: okColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(DialogAction.yes),
        ),
      ],
    ),
  );
  return (action != null) ? action : DialogAction.cancel;
}

String getFileExtension(String path) {
  List<String> values = path.split('/');
  List<String> extensions = values[values.length - 1].split('.');
  return extensions[extensions.length - 1];
}

String getFileName(String path) {
  List<String> values = path.split('/');
  return values[values.length - 1];
}

Future checkPermission() async {
  final status = await Permission.storage.status;
  if ((status == PermissionStatus.permanentlyDenied) ||
      (status == PermissionStatus.restricted)) {
    openAppSettings();
    return false;
  }
  if (status != PermissionStatus.granted) {
    final result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  } else {
    return true;
  }
  return false;
}

cachedNetworkImage({
  required String imgUrl,
  EdgeInsets? margin,
  double size = 50,
  double borderRadius = 5,
}) {
  final empty = Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      // shape: shape,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(width: 1, color: Colors.white),
    ),
  );
  return CachedNetworkImage(
    imageUrl: imgUrl,
    imageBuilder: (context, imageProvider) => Container(
      margin: const EdgeInsets.only(left: 0, top: 0),
      decoration: BoxDecoration(
        // shape: shape,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(width: 1, color: Colors.white),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    fit: BoxFit.cover,
    width: size,
    height: size,
    placeholder: (context, url) => const Loader(),
    errorWidget: (context, url, error) => empty,
  );
}

Future<void> customUrlLauncher(
  BuildContext context, {
  required String type,
  String? url,
  String? subject,
  String? body,
  String? lat,
  String? lng,
}) async {
  switch (type) {
    case "phone":
      Uri _uri = Uri.parse("tel:$url");
      if (!await launchUrl(_uri)) {
        if (!context.mounted) return;
        _throwCustomUrlLauncherError(context, "Oops!! Can't Make a call");
      }
      break;
    case "web":
      var _url = url!.contains("https://") || url.contains("http://")
          ? url
          : "https://$url";
      Uri _uri = Uri.parse(_url);
      if (!await launchUrl(_uri)) {
        if (!context.mounted) return;
        _throwCustomUrlLauncherError(context, "Oops!! Can't Open this website");
      }
      break;
    case "email":
      // launchUrl(Uri.parse("mailto:$url?subject=$subject&body=$body"));
      if (!await launchUrl(
          Uri.parse("mailto:$url?subject=$subject&body=$body"))) {
        if (!context.mounted) return;
        _throwCustomUrlLauncherError(context, "Can't open the email app");
      }
      break;
    case "map":
      // final Uri googleMapUrl = Uri.parse("comgooglemaps://?center=$lat,$lng");
      final Uri googleMapUrl = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$lat,$lng");
      final Uri appleMapUrl = Uri.parse("https://maps.apple.com?q=$lat,$lng");

      if (Platform.isAndroid) {
        if (!await launchUrl(googleMapUrl)) {
          if (!context.mounted) return;
          _throwCustomUrlLauncherError(context, "Can't launch Google map app");
        }
      } else if (Platform.isIOS) {
        if (!await launchUrl(appleMapUrl)) {
          if (!context.mounted) return;
          _throwCustomUrlLauncherError(context, "Can't launch Apple map app");
        }
      } else {
        // Launch with google maps
        if (!await launchUrl(googleMapUrl)) {
          if (!context.mounted) return;
          _throwCustomUrlLauncherError(context, "Can't launch Google map app");
        }
      }

      break;
    default:
      if (!context.mounted) return;
      _throwCustomUrlLauncherError(
          context, "Can't find appropriate app for this action");
  }
}

_throwCustomUrlLauncherError(BuildContext context, String err) {
  showError(message: err);
  throw err;
}

Future<File?> selectImageFromGallery() async {
  var selectedImage =
      // await locator.get<ImagePicker>().pickImage(source: ImageSource.gallery);
      await locator.get<ImagePicker>().pickImage(
            source: ImageSource.gallery,
            imageQuality: 10,
          );

  return isObjectEmpty(selectedImage) ? null : File(selectedImage!.path);
  // return isObjectEmpty(selectedImage)
  //     ? null
  //     : (await FlutterImageCompress.compressAndGetFile(
  //         selectedImage!.path,
  //         selectedImage.path,
  //         quality: 88,
  //         rotate: 180,
  //         format: CompressFormat.png,
  //       ) as File);
  // if (isObjectEmpty(selectedImage)) {
  //   return null;
  // } else {
  //   print("Gello George...");
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     selectedImage!.path,
  //     selectedImage.path,
  //     quality: 88,
  //     rotate: 180,
  //     format: CompressFormat.png,
  //   );
  //   print("George here is the actual file size: ${selectedImage.length()}");
  //   print("George here is the compressed file size: ${result?.length()}");
  //   return result as File;
  // }
}

Future<List<XFile>?> selectMultipleImageFromGallery({
  int max = 4,
}) async {
  final ImagePicker imagePicker = locator.get<ImagePicker>();
  List<XFile> projectImageFileList = [];
  final List<XFile> selectedImages =
      (await imagePicker.pickMultiImage(imageQuality: 10)).take(max).toList();
  if (selectedImages.isNotEmpty) {
    projectImageFileList.addAll(selectedImages);
    return projectImageFileList;
  } else {
    return null;
  }
}

showSimpleDialog({
  required BuildContext context,
  required Widget child,
  bool dismissable = true,
  bool isCancel = true,
  Color backgroundColor = Colors.white,
  VoidCallback? cancelFn,
  EdgeInsetsGeometry? padding,
  EdgeInsets? insetPadding,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissable,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: backgroundColor,
        insetPadding: insetPadding,
        child: Container(
          width: screenWidth(context),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      );
    },
  );
}

typedef void IntCallBack(int val);

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    this.value,
    required this.itemList,
    required this.onTap,
  });

  final List<String> itemList;
  final IntCallBack onTap;
  final dynamic value;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.value != null) {
      _selectedIndex =
          widget.itemList.indexWhere((element) => element == widget.value);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterToggleTab(
      width: 92,
      borderRadius: 5,
      height: 50,
      selectedIndex: _selectedIndex,
      selectedBackgroundColors: const [PRIMARY, PRIMARY],
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unSelectedTextStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labels: widget.itemList,
      selectedLabelIndex: (index) {
        setState(() {
          widget.onTap(index);
          _selectedIndex = index;
        });
      },
      // isScroll: false,
      isScroll: true,
    );
  }
}

typedef void DateCallBack(DateTime val);

class TextFieldDatePicker extends StatefulWidget {
  const TextFieldDatePicker({super.key, required this.dateCallBack});

  final DateCallBack dateCallBack;

  @override
  State<TextFieldDatePicker> createState() => _TextFieldDatePickerState();
}

class _TextFieldDatePickerState extends State<TextFieldDatePicker> {
  TextEditingController datePickerController = TextEditingController();
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(DateTime.now().year + 2),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
    widget.dateCallBack(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: datePickerController,
      readOnly: true,
      style: FORM_STYLE,
      decoration: FormUtils.formDecoration(
        labelText: "mm/dd/yyy",
        suffixIcon: const Icon(Icons.date_range_rounded),
      ),
      onTap: () => onTapFunction(context: context),
    );
  }
}

Text tosText(
  String text, {
  bool isUnderlined = false,
  double height = 1.2,
  TextAlign? textAlign,
}) {
  return subtext(
    text,
    fontSize: 12,
    textAlign: textAlign ?? TextAlign.center,
    fontWeight: FontWeight.w400,
    textDecoration: isUnderlined ? TextDecoration.underline : null,
    height: height,
  );
}

backBoxFn({required GestureCancelCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 56,
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          width: 1,
          color: BORDER,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 24,
        ),
      ),
    ),
  );
}

customDivider({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double? height = 30,
  Color? color = BORDER,
  double? thickness = 1,
}) {
  return Padding(
    padding: padding,
    child: Divider(
      height: height,
      thickness: thickness,
      color: color,
    ),
  );
}

class Subsection extends StatelessWidget {
  const Subsection({
    super.key,
    required this.leftSection,
    this.rightSection,
    this.withDivider = true,
    this.onTap,
  });

  final String leftSection;
  final String? rightSection;
  final bool withDivider;
  final GestureCancelCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            labelText(
              leftSection,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            if (!isObjectEmpty(rightSection)) ...[
              GestureDetector(
                onTap: onTap,
                child: subtext(
                  "$rightSection",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
        if (withDivider) ...[
          customDivider(),
          ySpace(height: 24),
        ],
      ],
    );
  }
}

socialInteractionIconWithVal({
  required String content,
  required GestureCancelCallback onTap,
  required IconData icon,
  double? iconSize = 13,
  double? textSize = 13,
  Color? color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: color,
        ),
        subtext(
          content,
          fontSize: textSize,
        ),
      ],
    ),
  );
}

Future<ShareResultStatus> shareDoc(
  BuildContext context, {
  String? url,
  String linkType = 'Profile',
}) async {
  final box = context.findRenderObject() as RenderBox?;

  var msg = '';
  switch (linkType) {
    case 'post':
      msg = 'Check out this post';
      break;
    default:
      msg = "Visit my profile on the nodes platform via ";
  }

  final result = await Share.shareWithResult(
    '$msg $url',
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
  if (result.status == ShareResultStatus.success) {
    debugPrint('Thank you for sharing my website!');
  }
  return ShareResultStatus.success;
}

dottedLines() {
  return const DottedLine(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    lineLength: double.infinity,
    lineThickness: 1.0,
    dashLength: 4.0,
    dashColor: BORDER,
    // dashGradient: [Colors.red, Colors.blue],
    dashRadius: 0.0,
    dashGapLength: 4.0,
    dashGapColor: Colors.transparent,
    // dashGapGradient: [Colors.red, Colors.blue],
    dashGapRadius: 0.0,
  );
}

String pwdStrengthText(val) {
  if (val == 0) {
    // empty
    return "";
  } else if (val <= .5) {
    // weak
    return "WEAK";
  } else if (val > .6 && val < 1) {
    // medium
    return "MEDIUM";
  }
  // strong
  return "STRONG";
}

GestureDetector tabHeader({
  required bool isActive,
  required String title,
  required GestureTapCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: isActive ? PRIMARY : TRANSPARENT,
          ),
        ),
      ),
      child: labelText(
        title,
        fontSize: 16,
        color: isActive ? PRIMARY : BLACK,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Container analyticsCard({
  required String title,
  required String value,
}) {
  return Container(
    padding: const EdgeInsets.all(
      16,
    ),
    decoration: BoxDecoration(
      color: WHITE,
      border: Border.all(
        width: 0.7,
        color: BORDER,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(
          title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        ySpace(height: 20),
        labelText(
          value,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}

Future<String> convertFileToString(String filePath) async =>
    "data:image/png;base64,${base64Encode(await (File(filePath).readAsBytes()))}";

String getShortName(String name) =>
    name.length > 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();

List<Widget> userSocials(UserModel user) {
  List<Widget> iconArr = [];

  if (!isObjectEmpty(user.linkedIn)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.linkedinIcon,
      ),
    );
  }
  if (!isObjectEmpty(user.instagram)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.instagramIcon,
      ),
    );
  }
  if (!isObjectEmpty(user.website)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.globeIcon,
      ),
    );
  }
  if (!isObjectEmpty(user.twitter)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.twitterIcon,
      ),
    );
  }
  return !isObjectEmpty(iconArr)
      ? iconArr
      : [
          SvgPicture.asset(
            ImageUtils.chainLinkIcon,
            color: GRAY,
          ),
          xSpace(width: 5),
          subtext(
            "Websites",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: GRAY,
          ),
        ];
}

List<Widget> userBusinessSocials(BusinessAccountModel business) {
  List<Widget> iconArr = [];

  if (!isObjectEmpty(business.linkedIn)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.linkedinIcon,
      ),
    );
  }
  if (!isObjectEmpty(business.instagram)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.instagramIcon,
      ),
    );
  }
  if (!isObjectEmpty(business.website)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.globeIcon,
      ),
    );
  }
  if (!isObjectEmpty(business.twitter)) {
    iconArr.add(
      iconWithLink(
        onTap: () {},
        icon: ImageUtils.twitterIcon,
      ),
    );
  }
  return !isObjectEmpty(iconArr)
      ? iconArr
      : [
          SvgPicture.asset(
            ImageUtils.chainLinkIcon,
            color: GRAY,
          ),
          xSpace(width: 5),
          subtext(
            "Websites",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: GRAY,
          ),
        ];
}

GestureDetector iconWithLink({
  required GestureTapCallback onTap,
  required String icon,
}) {
  return GestureDetector(onTap: onTap, child: SvgPicture.asset(icon));
}

Padding actionBtn({
  required String icon,
  required GestureTapCallback onTap,
  required bool loading,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: loading
        ? const Loader()
        : GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              icon,
              height: 30,
            ),
          ),
  );
}

bool isBusinessProfileComplete(BusinessAccountModel b) {
  // check if the following fields are available
  // Logo, Name, YOE, Location, Headline and Bio, for now sha...
  bool hasLogo = !isObjectEmpty(b.logo?.url);
  bool hasCac = !isObjectEmpty(b.cac?.url);
  bool hasName = !isObjectEmpty(b.name);
  bool hasYoe = !isObjectEmpty(b.yoe);
  bool hasLocation = !isObjectEmpty(b.location);
  bool hasHeadline = !isObjectEmpty(b.headline);
  bool hasBio = !isObjectEmpty(b.bio);
  if (hasCac &&
      hasLogo &&
      hasName &&
      hasYoe &&
      hasLocation &&
      hasHeadline &&
      hasBio) {
    // if (hasName && hasYoe && hasLocation) {
    return true;
  }
  return false;
}

bool isBusinessVerified(BusinessAccountModel b) {
  return b.verified;
}

bool isTalentProfileComplete(UserModel t) {
  bool hasAvatar = !isObjectEmpty(t.avatar?.url);
  bool hasName = !isObjectEmpty(t.name);
  bool hasDob = !isObjectEmpty(t.dob);
  bool hasLocation = !isObjectEmpty(t.location);
  bool hasHeadline = !isObjectEmpty(t.headline);
  bool hasBio = !isObjectEmpty(t.bio);
  if (hasAvatar && hasName && hasDob && hasLocation && hasHeadline && hasBio) {
    return true;
  }
  return false;
}

imagePreviewer(
  context, {
  required List<MediaUploadModel> images,
  required int index,
}) {
  List<ImageProvider> _arr = [];
  for (var i in images) {
    if (!isObjectEmpty(i.url)) {
      _arr.add(CachedNetworkImageProvider(i.url));
    }
  }
  MultiImageProvider multiImageProvider = MultiImageProvider(_arr);

  showImageViewerPager(
    context,
    multiImageProvider,
    closeButtonColor: RED,
    backgroundColor: BLACK,
    onPageChanged: (page) {
      // print("page changed to $page");
    },
    onViewerDismissed: (page) {
      // print("dismissed while on page $page");
    },
  );
}

singleImagePreviewer(context, {required MediaUploadModel image}) {
  showImageViewerPager(
    context,
    MultiImageProvider([CachedNetworkImageProvider(image.url)]),
    closeButtonColor: RED,
    backgroundColor: BLACK,
    onPageChanged: (page) {
      // print("page changed to $page");
    },
    onViewerDismissed: (page) {
      // print("dismissed while on page $page");
    },
  );
}
