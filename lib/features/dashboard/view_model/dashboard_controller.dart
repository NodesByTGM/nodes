// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/page.dart';
import 'package:nodes/features/dashboard/service/dashboard_service.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/features/saves/models/job_model.dart';
import 'package:nodes/utilities/constants/key_strings.dart';
import 'package:nodes/utilities/utils/utils.dart';

class DashboardController extends BaseController {
  final log = Logger('DashboardController');
  final DashboardService _dashboardService;

  DashboardController(this._dashboardService);

  // Variables
  List<JobModel> _savedJobsList = [];
  List<EventModel> _savedEventsList = [];

  // Getters
  List<JobModel> get savedJobs => _savedJobsList;
  List<EventModel> get savedEvents => _savedEventsList;

  // Setters

  // setCurrentlyViewedSpaceVal(dynamic val) {
  //   _currentlyViewedSpace = val;
  //   notifyListeners();
  // }

  setSavedJobs(List<JobModel> jobs) {
    _savedJobsList = jobs;
    notifyListeners();
  }

  setSavedEvents(List<EventModel> events) {
    _savedEventsList = events;
    notifyListeners();
  }

  // Functions

  // Events

  Future<bool> createEvent(dynamic payload) async {
    setCreatingEvent(true);
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
      setCreatingEvent(false);
    }
  }

  Future<bool> fetchAllEvents({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllEvents(true);
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
      setFetchingAllEvents(false);
    }
  }

  Future<bool> fetchSingleEvent(dynamic payload) async {
    setFetchingSingleEvent(true);
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
      setFetchingSingleEvent(false);
    }
  }

  Future<bool> updateSingleEvent({
    required dynamic id,
    required dynamic payload,
  }) async {
    setUpdatingEvent(true);
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
      setUpdatingEvent(false);
    }
  }

  Future<bool> deleteSingleEvent(dynamic payload) async {
    setDeleteEvent(true);
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
      setDeleteEvent(false);
    }
  }

  Future<bool> saveEvent(dynamic payload) async {
    setSavedUnsavedEvent(true);
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
      setSavedUnsavedEvent(false);
    }
  }

  Future<bool> unSaveEvent(dynamic payload) async {
    setSavedUnsavedEvent(true);
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
      setSavedUnsavedEvent(false);
    }
  }

  Future<bool> fetchAllSavedEvents({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllSavedEvents(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllSavedEvents(
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setSavedEvents(_resolvePaginatedSavedEvents(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllSavedEvents(false);
    }
  }

  Future<bool> fetchAllAllMyCreatedEvents({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllCreatedEvents(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllAllMyCreatedEvents(
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
      setFetchingAllCreatedEvents(false);
    }
  }

  // Jobs

  Future<bool> createJob(dynamic payload) async {
    setCreatingJob(true);
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
      setCreatingJob(false);
    }
  }

  Future<bool> fetchAllJobs({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllJobs(
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
      setFetchingAllJobs(false);
    }
  }

  Future<bool> fetchSingleJob(dynamic payload) async {
    setFetchingSingleJob(true);
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
      setFetchingSingleJob(false);
    }
  }

  Future<bool> updateSingleJob({
    required dynamic id,
    required dynamic payload,
  }) async {
    setUpdatingJob(true);
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
      setUpdatingJob(false);
    }
  }

  Future<bool> deleteSingleJob(dynamic payload) async {
    setDeleteJob(true);
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
      setDeleteJob(false);
    }
  }

  Future<bool> applyForJob(dynamic payload) async {
    setApplyingForJob(true);
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
      setApplyingForJob(false);
    }
  }

  Future<bool> saveJob(dynamic payload) async {
    setSavedUnsavedJob(true);
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
      setSavedUnsavedJob(false);
    }
  }

  Future<bool> unSaveJob(dynamic payload) async {
    setSavedUnsavedJob(true);
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
      setSavedUnsavedJob(false);
    }
  }

  Future<bool> fetchAllSavedJobs({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllSavedJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllSavedJobs(
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setSavedJobs(_resolvePaginatedSavedJobs(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllSavedJobs(false);
    }
  }

  Future<bool> fetchAllAppliedJobs({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllAppliedJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllAppliedJobs(
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
      setFetchingAllAppliedJobs(false);
    }
  }

  Future<bool> fetchAllMyCreatedJobs({
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllCreatedJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllMyCreatedJobs(
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
      setFetchingAllCreatedJobs(false);
    }
  }

// Handling Paginated Data...
  List<JobModel> _resolvePaginatedSavedJobs(ApiResponse response) {
    Page<JobModel> p = const Page<JobModel>()
        .fromJson(response.result as Map<String, dynamic>, const JobModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<JobModel>;
    }
    return [];
  }

  List<EventModel> _resolvePaginatedSavedEvents(ApiResponse response) {
    Page<EventModel> p = const Page<EventModel>()
        .fromJson(response.result as Map<String, dynamic>, const EventModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<EventModel>;
    }
    return [];
  }
}
