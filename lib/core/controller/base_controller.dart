import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

abstract class BaseController extends ChangeNotifier {
  final baseControllerLog = Logger("BaseController");

// Variables
  bool _busy = false;
  bool _searching = false;
  bool _isVerifyOTP = false;

// Getters
  bool get loading => _busy;
  bool get searching => _searching;
  bool get verifyOTPStatus => _isVerifyOTP;

  // Setters
  setBusy(bool value, {bool when = true}) {
    if (!when) {
      return;
    }
    _busy = value;
    notifyListeners();
  }

  setSearching(bool value) {
    _searching = value;
    notifyListeners();
  }

  setVerifyOTP(bool value) {
    _isVerifyOTP = value;
    notifyListeners();
  }

}
