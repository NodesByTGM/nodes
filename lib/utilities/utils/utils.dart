// ignore_for_file: constant_identifier_names, implementation_imports, prefer_generic_function_type_aliases

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bot_toast/src/toast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/form_utils.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:permission_handler/permission_handler.dart';

const FontFamily = "Raleway";

// Default Delay
Duration get screenDuration => const Duration(milliseconds: 200);

// Width of the current Screen Context
double screenWidth(context) => MediaQuery.of(context).size.width;

// Height of the current Screen Context
double screenHeight(context) => MediaQuery.of(context).size.height;

// Used to get a consistent Screen Padding
EdgeInsetsGeometry get screenPadding =>
    // const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0);
    const EdgeInsets.symmetric(horizontal: 20, vertical: 0);

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

String shortTime(DateTime now) => Jiffy.now().fromNow();
String formatDateOnly(DateTime now) => DateFormat.yMMMEd().format(now);
String formatDate(DateTime now) => DateFormat('yMd').format(now);
String fullDate(DateTime now) => DateFormat('d MMMM, y').format(now);
String shortDate(DateTime now) => DateFormat('dd MMMM, yyyy').format(now);

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
  List<String> names = s.split(' ');
  if (names.isNotEmpty) {
    return names
        .map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');
  }
  return s;
}

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
              style: const TextStyle(
                color: PRIMARY,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
          ),
        BasicDialogAction(
          title: Text(
            okTitle ?? Constants.ok,
            textScaleFactor: 1.0,
            style: const TextStyle(
              color: PRIMARY,
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
}) {
  final empty = Container(
    color: Colors.grey,
  );
  return CachedNetworkImage(
    imageUrl: imgUrl,
    imageBuilder: (context, imageProvider) => Container(
      margin: const EdgeInsets.only(left: 0, top: 0),
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
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
    placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
    errorWidget: (context, url, error) => empty,
  );
}

Future<File?> selectImageFromGallery() async {
  var selectedImage =
      await locator.get<ImagePicker>().pickImage(source: ImageSource.gallery);
  return isObjectEmpty(selectedImage) ? null : File(selectedImage!.path);
}

showSimpleDialog({
  required BuildContext context,
  required Widget child,
  bool dismissable = true,
  bool isCancel = true,
  Color backgroundColor = Colors.white,
  VoidCallback? cancelFn,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissable,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: backgroundColor,
        child: Container(
          width: screenWidth(context),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
            ],
          ),
        ),
      );
    },
  );
}

// Future<String?> imageUploader(File imageFile) async {
//   Cloudflare cloudflare = locator.get<Cloudflare>(); //apiUrl is optional
//   await cloudflare.init();
//   //From file
//   CloudflareHTTPResponse<CloudflareImage?> responseFromFile =
//       await cloudflare.imageAPI.upload(
//     contentFromFile: DataTransmit<File>(
//       data: imageFile,
//       progressCallback: (count, total) {
//         // print('George the Upload progress: $count/$total');
//       },
//     ),
//   );
//   return responseFromFile.body?.variants.first;
// }

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
    textAlign: textAlign?? TextAlign.center,
    fontWeight: FontWeight.w400,
    textDecoration: isUnderlined ? TextDecoration.underline : null,
    height: height,
  );
}
