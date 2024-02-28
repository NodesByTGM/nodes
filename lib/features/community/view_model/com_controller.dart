// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/features/community/service/com_service.dart';

class ComController extends BaseController {
  final log = Logger('ComController');
  final ComService _comService;

  ComController(this._comService);

  // Variables
  dynamic _currentlyViewedSpace =
      ""; // This should somehow have the description to denote if it was created by the user or not in the model.

  bool _dummyIsCreatedSpace = false;

  // Getters
  get currentlyViewedSpace => _currentlyViewedSpace;
  bool get dummyIsCreatedSpace => _dummyIsCreatedSpace;

  // Setters

  setCurrentlyViewedSpaceVal(dynamic val) {
    _currentlyViewedSpace = val;
    notifyListeners();
  }

  setDummyIsCreatedSpaceVal(bool val) {
    _dummyIsCreatedSpace = val;
    notifyListeners();
  }

  // set currentUserVal(CurrentSession session) {
  //   notifyListeners();
  // }

  // Functions
  // Future<bool> login(LoginDetails _details) async {
  //   setBusy(true);
  //   try {
  //     ApiResponse response = await _comService.login(_details);
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
}
