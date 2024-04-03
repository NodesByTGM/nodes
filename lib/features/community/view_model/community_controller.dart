// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/features/community/service/community_service.dart';
import 'package:nodes/utilities/constants/key_strings.dart';
import 'package:nodes/utilities/utils/utils.dart';

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
  Future<bool> createCommunityPost(dynamic _details) async {
    setBusy(true);
    try {
      ApiResponse response = await _comService.createCommunityPost(_details);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO: Do Something here...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> fetchAllCommunityPosts() async {
    setFetchCommunityPost(true);
    try {
      ApiResponse response = await _comService.fetchAllCommunityPosts();
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO: Do Something here...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchCommunityPost(false);
    }
  }

  Future<bool> fetchSingleCommunityPost(dynamic _details) async {
    setFetchSingleCommunityPost(true);
    try {
      ApiResponse response =
          await _comService.fetchSingleCommunityPost(_details);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO: Do Something here...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchSingleCommunityPost(false);
    }
  }

  Future<bool> likeSingleCommunityPost(dynamic _details) async {
    setLikeUnlikecommunityPost(true);
    try {
      ApiResponse response =
          await _comService.likeSingleCommunityPost(_details);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO: Do Something here...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setLikeUnlikecommunityPost(false);
    }
  }

  Future<bool> unlikeSingleCommunityPost(dynamic _details) async {
    setLikeUnlikecommunityPost(true);
    try {
      ApiResponse response =
          await _comService.unlikeSingleCommunityPost(_details);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO: Do Something here...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setLikeUnlikecommunityPost(false);
    }
  }
}
