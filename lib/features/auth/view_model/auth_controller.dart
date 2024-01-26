// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/core/models/page.dart';
import 'package:nodes/features/auth/service/auth_service.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class AuthController extends BaseController {
  final log = Logger('Authcontroller');
  final AuthService _authService;
  final LocalStorageService _storageService;

  AuthController(this._authService, this._storageService);

  // Variables
  // UserModel _currentUser = const UserModel();

  // Getters

  // UserModel get currentUser => _currentUser;
  Future<CurrentSession?> get currentSession async {
    var currentUser =
        await _storageService.getSecureJson(KeyString.currentSession);
    return (currentUser != null) ? CurrentSession.fromJson(currentUser!) : null;
  }

  String get currentScreen =>
      _storageService.getData(KeyString.currentScreen) ?? "/";


  // Setters

  set currentUserVal(CurrentSession session) {
    // _currentUser = session.user as UserModel;
    notifyListeners();
  }

  void setCurrentScreen(String screen) async {
    await _storageService.saveData(KeyString.currentScreen, screen);
  }

  Future<void> _saveSession(Map<String, dynamic> session) async {
    var _session = CurrentSession.fromJson(session);
    await saveCurrentSession(_session);
  }

  Future<void> saveCurrentSession(CurrentSession session) async {
    currentUserVal = session;
    await _storageService.saveSecureJson(KeyString.currentSession, session);
  }

  Future<void> _customSaveSession(ApiResponse res) async {
    CurrentSession _ =
        CurrentSession.fromJson(res.data as Map<String, dynamic>);
    CurrentSession? cS = await currentSession;
    if (isObjectEmpty(cS)) {
      // Meaning user is only signing in
      cS = const CurrentSession();
    }
    await _saveSession(cS!
        .copyWith(
          access: _.access,
          refresh: _.refresh,
          user_type: _.user_type,
          uid: _.uid,
          // user: currentUser.copyWith(
          //   user_type: _.user_type,
          //   uid: _.uid,
          // ),
        )
        .toJson());
  }


  // Functions
  // Future<bool> login(LoginDetails _details) async {
  //   setBusy(true);
  //   try {
  //     ApiResponse response = await _authService.login(_details);
  //     if (response.status == KeyString.error) {
  //       showError(message: errorMessageObjectToString(response.message));
  //       return false;
  //     }
  //     await _customSaveSession(response);
  //     setCurrentScreen(NavbarView.routeName);
  //     return true;
  //   } on NetworkException catch (e) {
  //     showError(message: e.toString());
  //     return false;
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  Future<String?> _deviceToken() async {
    // return await FirebaseMessaging.instance.getToken();
    return "";
  }

  

  // Future<bool> verifyOtp(String otp) async {
  //   setBusy(true);
  //   try {
  //     ApiResponse response = await _authService.verifyOtp(otp);

  //     if (response.status == KeyString.error) {
  //       showError(message: errorMessageObjectToString(response.message));
  //       return false;
  //     }
  //     await _customSaveSession(response);
  //     return true;
  //   } on NetworkException catch (e) {
  //     showError(message: e.toString());
  //     return false;
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  

  // Future<List<GuestModel>> searchGuest({required String query}) async {
  //   setBusy(true);
  //   try {
  //     ApiResponse response = await _authService.searchGuest(query);

  //     if (response.status == KeyString.error) {
  //       debugPrint(errorMessageObjectToString(response.message));
  //       return <GuestModel>[];
  //     }
  //     //
  //     Page<GuestModel> p = const Page<GuestModel>()
  //         .fromJson(response.data as Map<String, dynamic>, const GuestModel());
  //     if (!isObjectEmpty(p.results)) {
  //       return p.results as List<GuestModel>;
  //     }
  //     return <GuestModel>[];
  //   } on NetworkException catch (e) {
  //     debugPrint(e.toString());
  //     return [];
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  logout() {
    setBusy(false);
    _storageService.deleteSecure(KeyString.currentSession);
    _storageService.deleteSecure(KeyString.token);
    // _currentUser = const UserModel();
    notifyListeners();
  }
}
