// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/features/dashboard/service/dashboard_service.dart';
import 'package:nodes/utilities/constants/key_strings.dart';
import 'package:nodes/utilities/utils/utils.dart';

class DashboardController extends BaseController {
  final log = Logger('DashboardController');
  final DashboardService _dashboardService;

  DashboardController(this._dashboardService);

  // Variables

  // Getters

  // Setters

  // setCurrentlyViewedSpaceVal(dynamic val) {
  //   _currentlyViewedSpace = val;
  //   notifyListeners();
  // }

  // Functions

  // Events

  Future<bool> createEvent(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.createEvent(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllEvents({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllEvents(
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchSingleEvent(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchSingleEvent(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> updateSingleEvent({
    required dynamic id,
    required dynamic payload,
  }) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.updateSingleEvent(
        id: id,
        payload: payload,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> deleteSingleEvent(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.deleteSingleEvent(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> saveEvent(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.saveEvent(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> unSaveEvent(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.unSaveEvent(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllSavedEvents() async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllSavedEvents();
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllAllMyCreatedEvents() async {
    setBusy(true);
    try {
      ApiResponse response =
          await _dashboardService.fetchAllAllMyCreatedEvents();
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  // Jobs

  Future<bool> createJob(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.createJob(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllJobs({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllJobs(
        page: page,
        pageSize: pageSize,
      );
      print("George,,,,i'm here nowsdsd>...");
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      print("George these are all the Jobs: ${response.toJson()}");
      // TODO: Do Something here...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> fetchSingleJob(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchSingleJob(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> updateSingleJob({
    required dynamic id,
    required dynamic payload,
  }) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.updateSingleJob(
        id: id,
        payload: payload,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> deleteSingleJob(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.deleteSingleJob(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> applyForJob(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.applyForJob(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> saveJob(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.saveJob(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> unSaveJob(dynamic payload) async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.unSaveJob(payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllSavedJobs() async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllSavedJobs();
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllAppliedJobs() async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllAppliedJobs();
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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

  Future<bool> fetchAllMyCreatedJobs() async {
    setBusy(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllMyCreatedJobs();
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
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
}
