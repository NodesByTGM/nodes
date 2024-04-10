// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/custom_page.dart';
import 'package:nodes/features/dashboard/model/project_model.dart';
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
  List<SavedJobModel> _savedJobsList = [];
  List<JobModel> _jobsList = [];
  List<EventModel> _savedEventsList = [];
  List<EventModel> _eventsList = [];
  List<ProjectModel> _projectList = [];
  List<ProjectModel> _myProjectList = [];

  // Getters
  List<SavedJobModel> get savedJobsList => _savedJobsList;
  List<JobModel> get jobsList => _jobsList;
  List<EventModel> get savedEvents => _savedEventsList;
  List<EventModel> get eventsList => _eventsList;
  List<ProjectModel> get projectList => _projectList;
  List<ProjectModel> get myProjectList => _myProjectList;

  // Setters

  // setCurrentlyViewedSpaceVal(dynamic val) {
  //   _currentlyViewedSpace = val;
  //   notifyListeners();
  // }

  setSavedJobs(List<SavedJobModel> jobs) {
    _savedJobsList = jobs;
    notifyListeners();
  }

  setJobsList(List<JobModel> jobs) {
    _jobsList = jobs;
    notifyListeners();
  }

  setSavedEvents(List<EventModel> events) {
    _savedEventsList = events;
    notifyListeners();
  }

  setEventsList(List<EventModel> events) {
    _eventsList = events;
    notifyListeners();
  }

  setProjectList(List<ProjectModel> projects) {
    _projectList = projects;
    notifyListeners();
  }

  setMyProjectList(List<ProjectModel> projects) {
    _myProjectList = projects;
    notifyListeners();
  }

  _updateMyProjectList(ProjectModel project) {
    _myProjectList.add(project);
    notifyListeners();
  }

  // Functions

  // Events

  Future<bool> createProject(BuildContext ctx, dynamic payload) async {
    setCreatingProject(true);
    try {
      ApiResponse response =
          await _dashboardService.createProject(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      _updateMyProjectList(
        ProjectModel.fromJson(response.result as Map<String, dynamic>),
      );
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setCreatingProject(false);
    }
  }

  Future<bool> fetchAllProjects(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllProjects(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllProjects(
        ctx,
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setProjectList(_resolvePaginatedProjects(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllProjects(false);
    }
  }

  Future<bool> fetchMyProjects(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingMyProjects(true);
    try {
      ApiResponse response = await _dashboardService.fetchMyProjects(
        ctx,
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setMyProjectList(_resolvePaginatedProjects(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingMyProjects(false);
    }
  }

  Future<bool> createEvent(BuildContext ctx, dynamic payload) async {
    setCreatingEvent(true);
    try {
      ApiResponse response = await _dashboardService.createEvent(ctx, payload);
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

  Future<bool> fetchAllEvents(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllEvents(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllEvents(
        ctx,
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setEventsList(_resolvePaginatedEvents(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllEvents(false);
    }
  }

  Future<bool> fetchSingleEvent(BuildContext ctx, dynamic payload) async {
    setFetchingSingleEvent(true);
    try {
      ApiResponse response =
          await _dashboardService.fetchSingleEvent(ctx, payload);
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

  Future<bool> updateSingleEvent(
    BuildContext ctx, {
    required dynamic id,
    required dynamic payload,
  }) async {
    setUpdatingEvent(true);
    try {
      ApiResponse response = await _dashboardService.updateSingleEvent(
        ctx,
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

  Future<bool> deleteSingleEvent(BuildContext ctx, dynamic payload) async {
    setDeleteEvent(true);
    try {
      ApiResponse response =
          await _dashboardService.deleteSingleEvent(ctx, payload);
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

  Future<bool> saveEvent(BuildContext ctx, dynamic payload) async {
    setSavedUnsavedEvent(true);
    try {
      ApiResponse response = await _dashboardService.saveEvent(ctx, payload);
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

  Future<bool> unSaveEvent(BuildContext ctx, dynamic payload) async {
    setSavedUnsavedEvent(true);
    try {
      ApiResponse response = await _dashboardService.unSaveEvent(ctx, payload);
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

  Future<bool> fetchAllSavedEvents(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllSavedEvents(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllSavedEvents(
        ctx,
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setSavedEvents(_resolvePaginatedEvents(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllSavedEvents(false);
    }
  }

  Future<bool> fetchAllAllMyCreatedEvents(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllCreatedEvents(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllAllMyCreatedEvents(
        ctx,
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

  Future<bool> createJob(BuildContext ctx, dynamic payload) async {
    setCreatingJob(true);
    try {
      ApiResponse response = await _dashboardService.createJob(ctx, payload);
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

  Future<bool> fetchAllJobs(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllJobs(
        ctx,
        page: page,
        pageSize: pageSize,
      );
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      setJobsList(_resolvePaginatedJobs(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllJobs(false);
    }
  }

  Future<bool> fetchSingleJob(BuildContext ctx, dynamic payload) async {
    setFetchingSingleJob(true);
    try {
      ApiResponse response =
          await _dashboardService.fetchSingleJob(ctx, payload);
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

  Future<bool> updateSingleJob(
    BuildContext ctx, {
    required dynamic id,
    required dynamic payload,
  }) async {
    setUpdatingJob(true);
    try {
      ApiResponse response = await _dashboardService.updateSingleJob(
        ctx,
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

  Future<bool> deleteSingleJob(BuildContext ctx, dynamic payload) async {
    setDeleteJob(true);
    try {
      ApiResponse response =
          await _dashboardService.deleteSingleJob(ctx, payload);
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

  Future<bool> applyForJob(BuildContext ctx, dynamic payload) async {
    setApplyingForJob(true);
    try {
      ApiResponse response = await _dashboardService.applyForJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: Do Something here...
      // Add the applicant to the Applied arr...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setApplyingForJob(false);
    }
  }

  Future<bool> saveJob(BuildContext ctx, dynamic payload) async {
    setSavedUnsavedJob(true);
    try {
      ApiResponse response = await _dashboardService.saveJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // TODO: Do Something here...
      // Add the applicant to the saved arr.
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setSavedUnsavedJob(false);
    }
  }

  Future<bool> unSaveJob(BuildContext ctx, dynamic payload) async {
    setSavedUnsavedJob(true);
    try {
      ApiResponse response = await _dashboardService.unSaveJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: errorMessageObjectToString(response.message));
        return false;
      }
      // Remove the applicant from the saved arr.
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setSavedUnsavedJob(false);
    }
  }

  Future<bool> fetchAllSavedJobs(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllSavedJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllSavedJobs(
        ctx,
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

  Future<bool> fetchAllAppliedJobs(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllAppliedJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllAppliedJobs(
        ctx,
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

  Future<bool> fetchAllMyCreatedJobs(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setFetchingAllCreatedJobs(true);
    try {
      ApiResponse response = await _dashboardService.fetchAllMyCreatedJobs(
        ctx,
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
  List<SavedJobModel> _resolvePaginatedSavedJobs(ApiResponse response) {
    CustomPage<SavedJobModel> p = const CustomPage<SavedJobModel>().fromJson(
        response.result as Map<String, dynamic>, const SavedJobModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<SavedJobModel>;
    }
    return [];
  }

  List<JobModel> _resolvePaginatedJobs(ApiResponse response) {
    CustomPage<JobModel> p = const CustomPage<JobModel>()
        .fromJson(response.result as Map<String, dynamic>, const JobModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<JobModel>;
    }
    return [];
  }

  List<EventModel> _resolvePaginatedEvents(ApiResponse response) {
    CustomPage<EventModel> p = const CustomPage<EventModel>()
        .fromJson(response.result as Map<String, dynamic>, const EventModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<EventModel>;
    }
    return [];
  }

  List<ProjectModel> _resolvePaginatedProjects(ApiResponse response) {
    CustomPage<ProjectModel> p = const CustomPage<ProjectModel>().fromJson(
        response.result as Map<String, dynamic>, const ProjectModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<ProjectModel>;
    }
    return [];
  }
}
