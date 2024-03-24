// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/country_states.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/core/models/page.dart';
import 'package:nodes/features/auth/models/country_state_model.dart';
import 'package:nodes/features/auth/models/individual_talent_onboarding_model.dart';
import 'package:nodes/features/auth/models/register_model.dart';
import 'package:nodes/features/auth/service/auth_service.dart';
import 'package:nodes/features/home/views/navbar_view.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';




class AuthController extends BaseController {
  final log = Logger('Authcontroller');
  final AuthService _authService;
  final LocalStorageService _storageService;

  AuthController(
    this._authService,
    this._storageService,
  );

  // Variables
  // UserModel _currentUser = const UserModel();
  int _tStepperVal = 1;
  int _bStepperVal = 1;
  RegisterModel _registerData = const RegisterModel();
  double _passwordStrength = 0.0;
  IndividualTalentOnboardingModel _individualTalentData =
      const IndividualTalentOnboardingModel();

List<CountryStateModel> _countryStatesList = const CountryStateModel().fromList(countryStatesData);

  // Getters

  // UserModel get currentUser => _currentUser;
  Future<CurrentSession?> get currentSession async {
    var currentUser =
        await _storageService.getSecureJson(KeyString.currentSession);
    return (currentUser != null) ? CurrentSession.fromJson(currentUser!) : null;
  }

  String get currentScreen =>
      _storageService.getData(KeyString.currentScreen) ?? "/";

  int get tStepperVal => _tStepperVal;
  int get bStepperVal => _bStepperVal;
  RegisterModel get registerData => _registerData;
  double get passwordStrength => _passwordStrength;
  IndividualTalentOnboardingModel get individualTalentData =>
      _individualTalentData;

  List<CountryStateModel> get countryStatesList    =>  _countryStatesList;


  // Setters

  setTStepper(int val) {
    _tStepperVal = val;
    notifyListeners();
  }

  setBStepper(int val) {
    _bStepperVal = val;
    notifyListeners();
  }

  resetBTStepper() {
    _tStepperVal = 1;
    _bStepperVal = 1;
    notifyListeners();
  }

  dummySession(Map<String, dynamic> json) {
    _saveSession(json);
  }

  setPasswordStrength(double val) {
    _passwordStrength += val;
    notifyListeners();
  }

  setRegisterData(RegisterModel data) {
    _registerData = data;
    notifyListeners();
  }

  setIndividualTalentData(IndividualTalentOnboardingModel data) {
    _individualTalentData = data;
    notifyListeners();
  }

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
  Future<String?> _deviceToken() async {
    // return await FirebaseMessaging.instance.getToken();
    return "";
  }

  Future<bool> login(_details) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.login(_details);
      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // await _customSaveSession(response);
      // setCurrentScreen(NavbarView.routeName);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  ///
  ///

  Future<bool> register(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.register(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> refreshToken() async {
    setBusy(true);
    try {
      var refreshToken = ''; // from session
      ApiResponse response = await _authService.refreshToken(refreshToken);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> sendOTP(String email) async {
    setVerifyOTP(true);
    try {
      ApiResponse response = await _authService.sendOTP({'email': email});

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      showText(message: response.message);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setVerifyOTP(false);
    }
  }

  Future<bool> verifyEmail(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.verifyEmail(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      showText(message: response.message);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> verifyOTP(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.verifyOTP(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      showText(message: response.message);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> forgotPassword(String email) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.forgotPassword(email);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      // Password reset link sent successfully
      showText(message: response.message);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> resetPassword({
    required dynamic id,
    required dynamic token,
    required dynamic payload,
  }) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.resetPassword(
        id: id,
        token: token,
        payload: payload,
      );

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> changePassword(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.changePassword(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> serverLogout() async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.logout();

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> individualOnboarding(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.individualOnboarding(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> talentOnboarding(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.talentOnboarding(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> businessOnboarding(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.businessOnboarding(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> fetchProfile() async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.fetchProfile();

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> updateProfile(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.updateProfile(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> talentAccountUpgrade(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.talentAccountUpgrade(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> businessAccountUpgrade(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.businessAccountUpgrade(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> mediaUpload(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.mediaUpload(payload);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> deleteMedia(String id) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.deleteMedia(id);

      if (response.status == KeyString.error) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: DO SOMETHING HERE
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  ///
  logout() {
    setBusy(false);
    _storageService.deleteSecure(KeyString.currentSession);
    _storageService.deleteSecure(KeyString.token);
    // _currentUser = const UserModel();

    notifyListeners();
  }
}
