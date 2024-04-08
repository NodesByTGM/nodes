// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/features/community/service/space_service.dart';
import 'package:nodes/utilities/constants/key_strings.dart';
import 'package:nodes/utilities/utils/utils.dart';

class SpaceController extends BaseController {
  final log = Logger('SpaceController');
  final SpaceService _spaceService;

  SpaceController(this._spaceService);

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
  Future<bool> createSpace(BuildContext ctx,dynamic _details) async {
    setBusy(true);
    try {
      ApiResponse response = await _spaceService.createSpace(ctx,_details);
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

  Future<bool> fetchAllSpaces(BuildContext ctx,{
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchSpace(true);
    try {
      ApiResponse response = await _spaceService.fetchAllSpaces(ctx,
        page: page,
        pageSize: pageSize,
      );
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
      setFetchSpace(false);
    }
  }

  Future<bool> fetchAllMySpaces(BuildContext ctx,{
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchSpace(true);
    try {
      ApiResponse response = await _spaceService.fetchAllMySpaces(ctx,
        page: page,
        pageSize: pageSize,
      );
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
      setFetchSpace(false);
    }
  }

  Future<bool> fetchSingleSpace(BuildContext ctx,dynamic details) async {
    setFetchSingleSpace(true);
    try {
      ApiResponse response = await _spaceService.fetchSingleSpace(ctx,details);
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
      setFetchSingleSpace(false);
    }
  }

  Future<bool> updateSingleSpace(BuildContext ctx,{required dynamic id, required dynamic details}) async {
    setUpdatingSingleSpace(true);
    try {
      ApiResponse response = await _spaceService.updateSingleSpace(ctx,id: id, payload: details,);
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
      setUpdatingSingleSpace(false);
    }
  }

  Future<bool> joinSpace(BuildContext ctx,dynamic details) async {
    setJoinSpace(true);
    try {
      ApiResponse response = await _spaceService.joinSpace(ctx,details);
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
      setJoinSpace(false);
    }
  }

  Future<bool> leaveSpace(BuildContext ctx,dynamic details) async {
    setLeaveSpace(true);
    try {
      ApiResponse response = await _spaceService.leaveSpace(ctx,details);
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
      setLeaveSpace(false);
    }
  }

  Future<bool> addMemberToSpace(BuildContext ctx,dynamic details) async {
    setAddSpaceMember(true);
    try {
      ApiResponse response = await _spaceService.addMemberToSpace(ctx,details);
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
      setAddSpaceMember(false);
    }
  }

  Future<bool> removeMemberFromSpace(BuildContext ctx,dynamic details) async {
    setRemoveSpaceMember(true);
    try {
      ApiResponse response = await _spaceService.removeMemberFromSpace(ctx,details);
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
      setRemoveSpaceMember(false);
    }
  }

  Future<bool> makeSpaceAdmin(BuildContext ctx,dynamic details) async {
    setMakeSpaceAdmin(true);
    try {
      ApiResponse response = await _spaceService.makeSpaceAdmin(ctx,details);
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
      setMakeSpaceAdmin(false);
    }
  }

  //
}
