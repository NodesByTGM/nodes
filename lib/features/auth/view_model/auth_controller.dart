// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/country_states.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/current_session.dart';
import 'package:nodes/features/auth/models/country_state_model.dart';
import 'package:nodes/features/auth/models/individual_talent_onboarding_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:nodes/features/auth/models/refresh_token_model.dart';
import 'package:nodes/features/auth/models/register_model.dart';
import 'package:nodes/features/auth/models/subscription_upgrade_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/auth/service/auth_service.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
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
  UserModel _currentUser = const UserModel();
  int _tStepperVal = 1;
  int _bStepperVal = 1;
  RegisterModel _registerData = const RegisterModel();
  IndividualTalentOnboardingModel _individualTalentData =
      const IndividualTalentOnboardingModel();
  SubscriptionUpgrade _subUpgrade = const SubscriptionUpgrade();

  final List<CountryStateModel> _countryStatesList =
      const CountryStateModel().fromList(countryStatesData);

  GoogleSignIn googleSignIn = GoogleSignIn();

  // Getters

  UserModel get currentUser => _currentUser;
  Future<CurrentSession?> get currentSession async {
    var _currentSession =
        await _storageService.getSecureJson(KeyString.currentSession);
    return (_currentSession != null)
        ? CurrentSession.fromJson(_currentSession!)
        : null;
  }

  String get currentScreen =>
      _storageService.getData(KeyString.currentScreen) ?? "/";

  int get tStepperVal => _tStepperVal;
  int get bStepperVal => _bStepperVal;
  RegisterModel get registerData => _registerData;
  IndividualTalentOnboardingModel get individualTalentData =>
      _individualTalentData;

  List<CountryStateModel> get countryStatesList => _countryStatesList;
  SubscriptionUpgrade get subUpgrade => _subUpgrade;
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

  setSubUpgrade(SubscriptionUpgrade sub) {
    _subUpgrade = sub;
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
    _currentUser = session.user as UserModel;
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

  Future<void> _authCustomSaveSession(ApiResponse res) async {
    CurrentSession _ =
        CurrentSession.fromJson(res.result as Map<String, dynamic>);
    CurrentSession? cS = await currentSession;
    if (isObjectEmpty(cS)) {
      // Meaning user is only signing in
      cS = const CurrentSession();
    }
    await _saveSession(cS!
        .copyWith(
          accessToken: _.accessToken,
          refreshToken: _.refreshToken,
          user: _.user,
        )
        .toJson());
  }

  Future<void> _customUserSessionUpdate(ApiResponse res) async {
    UserModel user = UserModel.fromJson(res.result as Map<String, dynamic>);
    CurrentSession? cS = await currentSession;
    if (isObjectEmpty(cS)) {
      // Meaning user is only signing in
      cS = const CurrentSession();
    }
    await _saveSession(cS!
        .copyWith(
          user: user,
        )
        .toJson());
  }

  Future<void> _customRefreshTokenSessionUpdate(ApiResponse res) async {
    RefreshTokenModel tokenData =
        RefreshTokenModel.fromJson(res.result as Map<String, dynamic>);

    CurrentSession? cS = await currentSession;
    if (isObjectEmpty(cS)) {
      // Meaning user is only signing in
      cS = const CurrentSession();
    }
    await _saveSession(cS!
        .copyWith(
            accessToken: tokenData.accessToken,
            refreshToken: tokenData.refreshToken)
        .toJson());
  }

  // Functions
  Future<String?> _deviceToken() async {
    // return await FirebaseMessaging.instance.getToken();
    return "";
  }

  Future<UserModel?> login(_details) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.login(_details);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      showSuccess(message: response.message); // For login o
      await _authCustomSaveSession(response);
      // setCurrentScreen(NavbarView.routeName);
      return CurrentSession.fromJson(response.result as Map<String, dynamic>)
          .user;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
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
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // save the users data to localStorage
      await _authCustomSaveSession(response);
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
      // var refreshToken = (await currentSession)?.refreshToken; // from session
      var refreshToken = (await currentSession)?.refreshToken; // from session

      ApiResponse response = await _authService.refreshToken(refreshToken);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // remove accessToken from session first...
      await _customRefreshTokenSessionUpdate(response);
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

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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
      ApiResponse response = await _authService.forgotPassword(
        {
          "email": email,
        },
      );

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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

  Future<bool> changePassword(BuildContext ctx, dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.changePassword(ctx, payload);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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

  Future<bool> serverLogout(BuildContext ctx) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.logout(ctx);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
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

  Future<GoogleSignInAccount?> signUpWithGoogle(BuildContext ctx) async {
    setBusy(true);
    GoogleSignInAccount? user;
    try {
      await googleSignIn.signOut();
      user = await googleSignIn.signIn();
      // ApiResponse response = await _authService.logout(ctx);

      // if (response.status == KeyString.failure) {
      //   showError(message: response.message);
      //   return null;
      // }
      return user;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
    } finally {
      setBusy(false);
    }
  }

// Payload would be signup query
  // Future<UserModel?> completeOAuthSignup(
  //     BuildContext ctx, dynamic payload) async {
  //   setBusy(true);
  //   try {
  //     var firebaseToken = await _deviceToken();
  //     ApiResponse response = await _authService.registerWithOAuth(
  //       ctx: ctx,
  //       payload: payload,
  //     );

  //     if (response.status == KeyString.failure) {
  //       showError(message: response.message);
  //       return null;
  //     }
  //     return UserModel.fromJson(response.result as Map<String, dynamic>);
  //   } on NetworkException catch (e) {
  //     showError(message: e.toString());
  //     return null;
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  // Future<bool> completeOAuthSignIn(
  //   BuildContext ctx,
  //   dynamic payload,
  // ) async {
  //   setBusy(true);
  //   try {
  //     ApiResponse response =
  //         await _authService.completeOAuthSignup(ctx: ctx, payload: payload);

  //     if (response.status == KeyString.failure) {
  //       showError(message: response.message);
  //       return false;
  //     }
  //     return true;
  //   } on NetworkException catch (e) {
  //     showError(message: e.toString());
  //     return false;
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  // Future<AppleUserModel?> continueWithApple(
  //   BuildContext ctx,
  //   dynamic payload,
  // ) async {
  //   setBusy(true);
  //   AppleUserModel? appleUser;
  //   AuthorizationCredentialAppleID? cred;
  //   try {
  //     cred = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //     if (cred.email != null) {
  //       // This means first time the apple auth is used on the app...
  //       // Hit the create temp apple storage
  //       appleUser = AppleUserModel(
  //         email: cred.email,
  //         fullname: "${cred.givenName} ${cred.familyName}",
  //       );
  //     } else if (cred.givenName != null && cred.email == null) {
  //       // Using this to check if the user choose not to share email...
  //       return const AppleUserModel(email: null, fullname: null);
  //     } else {
  //       // This means that it's not the first time the apple auth is used on the app...
  //       // I'll need to send the identityToken to retrieve the user's details from the DB
  //       // iin cases where it can't retrieve thh user, what happens?
  //       AppleUserModel _res = await _authService.retrieveAppleUser(
  //         jwtToken: cred.identityToken,
  //       );
  //       // To return the email, and fullname...
  //       appleUser = AppleUserModel(
  //         email: _res.email,
  //         fullname: _res.fullname,
  //       );
  //     }
  //     return appleUser;
  //   } on NetworkException catch (e) {
  //     showError(message: e.toString());
  //     return null;
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  Future<bool> onboarding(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.onboarding(payload);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      await _customUserSessionUpdate(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> verifyBusiness(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.verifyBusiness(payload);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      await _customUserSessionUpdate(response);
      showSuccess(message: response.message);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> fetchProfile(BuildContext ctx) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.fetchProfile(ctx);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      await _customUserSessionUpdate(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> updateProfile(BuildContext ctx, dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.updateProfile(ctx, payload);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      showSuccess(message: response.message);
      await _customUserSessionUpdate(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> updateBusinessProfile(BuildContext ctx, dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response =
          await _authService.updateBusinessProfile(ctx, payload);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      showSuccess(message: response.message);
      await _customUserSessionUpdate(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  // Future<String?> mediaUpload(File file) async {
  //   setUploadingMedia(true);
  //   try {
  //     ApiResponse response = await _authService.mediaUpload(file);

  //     if (response.status == KeyString.failure) {
  //       showError(message: response.message);
  //       return null;
  //     }
  //     MediaUploadModel data =
  //         MediaUploadModel.fromJson(response.result as Map<String, dynamic>);
  //     return data.url;
  //   } on NetworkException catch (e) {
  //     showError(message: e.toString());
  //     return null;
  //   } finally {
  //     setUploadingMedia(false);
  //   }
  // }

  Future<MediaUploadModel?> mediaUpload(dynamic file) async {
    setUploadingMedia(true);
    try {
      ApiResponse response = await _authService.mediaUpload({
        "file": file,
      });

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      MediaUploadModel data =
          MediaUploadModel.fromJson(response.result as Map<String, dynamic>);
      return data;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
    } finally {
      setUploadingMedia(false);
    }
  }

  Future<bool> deleteMedia(String id) async {
    setUploadingMedia(true);
    try {
      ApiResponse response = await _authService.deleteMedia(id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setUploadingMedia(false);
    }
  }

  Future<CustomPaystackResModel?> getPaystackAuthUrl(
    BuildContext ctx,
    CustomPaystackModel payload,
  ) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.getPaystackAuthUrl(
        ctx,
        payload,
      );

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      return CustomPaystackResModel.fromJson(
          response.result as Map<String, dynamic>);
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> verifyAndUpgradeSubscription(
    dynamic payload,
  ) async {
    setBusy(true);
    try {
      ApiResponse response = await _authService.verifyAndUpgradeSubscription(
        payload,
      );

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      showSuccess(message: response.message);
      await _customUserSessionUpdate(response);
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
    _currentUser = const UserModel();
    setCurrentScreen(WelcomeBackScreen.routeName);
    notifyListeners();
  }
}
