// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously

// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/custom_page.dart';
import 'package:nodes/features/dashboard/model/movie_show_model.dart';
import 'package:nodes/features/dashboard/model/project_model.dart';
import 'package:nodes/features/dashboard/model/trending_model.dart';
import 'package:nodes/features/dashboard/service/dashboard_service.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/features/saves/models/event_model_standardTalent.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';
import 'package:nodes/utilities/constants/key_strings.dart';
import 'package:nodes/utilities/utils/utils.dart';

class DashboardController extends BaseController {
  final log = Logger('DashboardController');
  final DashboardService _dashboardService;

  DashboardController(this._dashboardService);

  // <================= Variables Starts here =================>
  // Jobs
  List<StandardTalentJobModel> _savedJobsList = [];
  List<StandardTalentJobModel> _jobsList = [];
  List<StandardTalentJobModel> _appliedJobsList = [];
  List<BusinessJobModel> _createdJobList = [];
  BusinessJobModel _currentlyViewedBusinessJob = const BusinessJobModel();
  // Events
  EventModel _currentlyViewedBusinessEvent = const EventModel();
  List<StandardTalentEventModel> _savedEventsList = [];
  List<StandardTalentEventModel> _eventsList = [];
  List<EventModel> _myCreatedEventsList = [];
  // Project
  List<ProjectModel> _projectList = [];
  List<ProjectModel> _myProjectList = [];
  List<TrendingModel> _trendingList = [];
  List<MovieShowModel> _movieShowList = [];

  // <================= Getters Starts here =====================>
  List<StandardTalentJobModel> get savedJobsList => _savedJobsList;
  List<StandardTalentJobModel> get jobsList => _jobsList;
  BusinessJobModel get currentlyViewedBusinessJob =>
      _currentlyViewedBusinessJob;
  List<StandardTalentJobModel> get appliedJobsList => _appliedJobsList;
  List<BusinessJobModel> get createdJobList => _createdJobList;
  EventModel get currentlyViewedBusinessEvent => _currentlyViewedBusinessEvent;
  List<StandardTalentEventModel> get savedEvents => _savedEventsList;
  List<StandardTalentEventModel> get eventsList => _eventsList;
  List<EventModel> get myCreatedEventsList => _myCreatedEventsList;
  List<ProjectModel> get projectList => _projectList;
  List<ProjectModel> get myProjectList => _myProjectList;
  List<TrendingModel> get trendingList => _trendingList;
  List<MovieShowModel> get movieShowList => _movieShowList;

  // <================= Setters Starts here =================>

  // setCurrentlyViewedSpaceVal(dynamic val) {
  //   _currentlyViewedSpace = val;
  //   notifyListeners();
  // }

// Jobs
  setSavedJobs(List<StandardTalentJobModel> jobs) {
    _savedJobsList = jobs;
    notifyListeners();
  }

  setJobsList(List<StandardTalentJobModel> jobs) {
    _jobsList = jobs;
    notifyListeners();
  }

  setCurrentlyViewedJob(BusinessJobModel job) {
    _currentlyViewedBusinessJob = job;
    notifyListeners();
  }

  setAppliedJobList(List<StandardTalentJobModel> job) {
    _appliedJobsList = job;
    notifyListeners();
  }

  setMyCreatedJobList(List<BusinessJobModel> job) {
    _createdJobList = job;
    notifyListeners();
  }

  _updateSingleJob(BusinessJobModel job) {
    int jIndex = _createdJobList.indexWhere((e) => e.id == job.id);
    if (jIndex != -1) {
      _createdJobList[jIndex] = job;
    } else {
      // Means it should add/ i.e created a new one in the list
      _createdJobList.add(job);
    }
    _currentlyViewedBusinessJob = job;
    notifyListeners();
  }

  _updateAppliedJobsList(StandardTalentJobModel job) {
    _appliedJobsList.add(job);
    _patchJobAppliedJobList(job: job, savedStatus: job.saved);
    notifyListeners();
  }

  // _updateSavedJobsList(
  //   BuildContext ctx, {
  //   required StandardTalentJobModel job,
  //   required bool isSave,
  // }) {
  //   int jI = _jobsList.indexWhere((jd) => jd.id == job.id);
  //   if (isSave) {
  //     _savedJobsList.add(job.copyWith(saved: isSave));
  //     if (jI != -1) {
  //       _jobsList[jI] = job.copyWith(saved: isSave);
  //     }
  //   } else {
  //     int jIndex = _savedJobsList.indexWhere((jd) => jd.id == job.id);
  //     if (jIndex != -1) {
  //       // Found something...
  //       _savedJobsList[jIndex] = job.copyWith(saved: isSave);
  //     }
  //   }
  //   notifyListeners();
  // }

  _updateSavedJobsList(
    BuildContext ctx, {
    required StandardTalentJobModel job,
    required bool isSave,
  }) {
    if (isSave) {
      _savedJobsList.add(job.copyWith(saved: isSave));
      _patchJobAppliedJobList(job: job, savedStatus: isSave);
    } else {
      int sJLI = _savedJobsList.indexWhere((jd) => jd.id == job.id);
      if (sJLI != -1) {
        // Found something...
        _savedJobsList.removeAt(sJLI);
      }
      _patchJobAppliedJobList(job: job, savedStatus: isSave);
    }
    notifyListeners();
  }

  _patchJobAppliedJobList({
    required StandardTalentJobModel job,
    required bool savedStatus,
  }) {
    int jLI = _jobsList.indexWhere((jd) => jd.id == job.id);
    int aJLI = _appliedJobsList.indexWhere((jd) => jd.id == job.id);
    if (jLI != -1) {
      // Meaning, the job is in the joblist, hence we update the saved status
      _jobsList[jLI] = job.copyWith(
        saved: savedStatus,
        applied: job.applied,
      );
    }
    if (aJLI != -1) {
      // Meaning, the job is in the appliedJobsList, hence we update the saved status
      _appliedJobsList[aJLI] = job.copyWith(
        saved: savedStatus,
        applied: job.applied,
      );
    }
  }

  _deleteSingleJob(String id) {
    int jIndex = _createdJobList.indexWhere((e) => e.id == id);
    if (jIndex != -1) {
      _createdJobList.removeWhere((e) => e.id == id);
    }
    notifyListeners();
  }

// Events
  setSavedEvents(List<StandardTalentEventModel> events) {
    _savedEventsList = events;
    notifyListeners();
  }

  setEventsList(List<StandardTalentEventModel> events) {
    _eventsList = events;
    notifyListeners();
  }

  setCurrentlyViewedEvent(EventModel event) {
    _currentlyViewedBusinessEvent = event;
    notifyListeners();
  }

  setMyCreatedEventList(List<EventModel> events) {
    _myCreatedEventsList = events;
    notifyListeners();
  }

  _updateSingleEvent(EventModel event) {
    int eIndex = _myCreatedEventsList.indexWhere((e) => e.id == event.id);
    if (eIndex != -1) {
      _myCreatedEventsList[eIndex] = event;
    } else {
      // Means it should add/ i.e created a new one in the list
      _myCreatedEventsList.add(event);
    }
    _currentlyViewedBusinessEvent = event; // This will update the data
    notifyListeners();
  }

  _deleteSingleEvent(String id) {
    int eIndex = _myCreatedEventsList.indexWhere((e) => e.id == id);
    if (eIndex != -1) {
      _myCreatedEventsList.removeWhere((e) => e.id == id);
    }
    notifyListeners();
  }

  _updateSavedEventsList(
    BuildContext ctx, {
    required StandardTalentEventModel event,
    required bool isSave,
  }) {
    if (isSave) {
      _savedEventsList.add(event.copyWith(saved: isSave));
    } else {
      int eIndex = _savedJobsList.indexWhere((e) => e.id == event.id);
      if (eIndex != -1) {
        // Found something...
        // _savedEventsList[eIndex].saves?.removeWhere((savers) => savers.id == ctx.read<AuthController>().currentUser.id);
        _savedEventsList[eIndex] = event.copyWith(saved: isSave);
      }
    }
    notifyListeners();
  }

// Projects
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

  // Trending
  setTrendingList(List<TrendingModel> trending) {
    _trendingList = trending;
    notifyListeners();
  }

  // MovieShows

  setMovieShowList(List<MovieShowModel> data) {
    _movieShowList = data;
    notifyListeners();
  }

  resetDashCtrl() {
_savedJobsList = [];
_appliedJobsList = [];
_createdJobList = [];
_currentlyViewedBusinessJob = const BusinessJobModel();
_currentlyViewedBusinessEvent = const EventModel();
_savedEventsList = [];
_myCreatedEventsList = [];
_projectList = [];
_myProjectList = [];
    notifyListeners();
  }

  // <================= Functions Starts here =================>

  // Projects

  Future<bool> createProject(BuildContext ctx, dynamic payload) async {
    setCreatingProject(true);
    try {
      ApiResponse response =
          await _dashboardService.createProject(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
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
        showError(message: response.message);
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
        showError(message: response.message);
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

//
//
// Events
//
//
  Future<bool> createEvent(BuildContext ctx, dynamic payload) async {
    setCreatingEvent(true);
    try {
      ApiResponse response = await _dashboardService.createEvent(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      _updateSingleEvent(
        EventModel.fromJson(response.result as Map<String, dynamic>),
      );
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
        showError(message: response.message);
        return false;
      }
      setEventsList(_resolvePaginatedStandardTalentEvents(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllEvents(false);
    }
  }

  Future<EventModel?> fetchSingleEvent(
      BuildContext ctx, dynamic payload) async {
    setFetchingSingleEvent(true);
    try {
      ApiResponse response =
          await _dashboardService.fetchSingleEvent(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      return EventModel.fromJson(response.result as Map<String, dynamic>);
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
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
        showError(message: response.message);
        return false;
      }
      _updateSingleEvent(
        EventModel.fromJson(response.result as Map<String, dynamic>),
      );
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setUpdatingEvent(false);
    }
  }

  Future<bool> deleteSingleEvent(BuildContext ctx, dynamic id) async {
    setDeleteEvent(true);
    try {
      ApiResponse response = await _dashboardService.deleteSingleEvent(ctx, id);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      _deleteSingleEvent(id);
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
        showError(message: response.message);
        return false;
      }
      _updateSavedEventsList(
        ctx,
        isSave: true,
        event: StandardTalentEventModel.fromJson(
          response.result as Map<String, dynamic>,
        ),
      );
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
        showError(message: response.message);
        return false;
      }
      _updateSavedEventsList(
        ctx,
        isSave: true,
        event: StandardTalentEventModel.fromJson(
            response.result as Map<String, dynamic>),
      );
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
        showError(message: response.message);
        return false;
      }
      setSavedEvents(_resolvePaginatedStandardTalentEvents(response));
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
        showError(message: response.message);
        return false;
      }
      setMyCreatedEventList(_resolvePaginatedEvents(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllCreatedEvents(false);
    }
  }

  ///
  ///
  ///
  ///  JOBS SECTION
  ///
  ///
  ///
  ///

  Future<bool> createJob(BuildContext ctx, dynamic payload) async {
    setCreatingJob(true);
    try {
      ApiResponse response = await _dashboardService.createJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      _updateSingleJob(
        BusinessJobModel.fromJson(response.result as Map<String, dynamic>),
      );
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
        showError(message: response.message);
        return false;
      }
      setJobsList(_resolvePaginatedStandardTalentJobs(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllJobs(false);
    }
  }

  Future<StandardTalentJobModel?> fetchSingleJob(
      BuildContext ctx, dynamic payload) async {
    setFetchingSingleJob(true);
    try {
      ApiResponse response =
          await _dashboardService.fetchSingleJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      return StandardTalentJobModel.fromJson(
          response.result as Map<String, dynamic>);
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
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
        showError(message: response.message);
        return false;
      }
      _updateSingleJob(
        BusinessJobModel.fromJson(response.result as Map<String, dynamic>),
      );
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setUpdatingJob(false);
    }
  }

  Future<bool> deleteSingleJob(BuildContext ctx, dynamic id) async {
    setDeleteJob(true);
    try {
      ApiResponse response = await _dashboardService.deleteSingleJob(ctx, id);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      showSuccess(message: response.message);
      _deleteSingleJob(id);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setDeleteJob(false);
    }
  }

  Future<StandardTalentJobModel?> applyForJob(
    BuildContext ctx,
    dynamic payload,
  ) async {
    setApplyingForJob(true);
    try {
      ApiResponse response = await _dashboardService.applyForJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }

      StandardTalentJobModel job = StandardTalentJobModel.fromJson(
        response.result as Map<String, dynamic>,
      );
      _updateAppliedJobsList(job);
      return job;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
    } finally {
      setApplyingForJob(false);
    }
  }

  Future<StandardTalentJobModel?> saveJob(
    BuildContext ctx,
    dynamic payload,
  ) async {
    setSavedUnsavedJob(true);
    try {
      ApiResponse response = await _dashboardService.saveJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      StandardTalentJobModel job = StandardTalentJobModel.fromJson(
        response.result as Map<String, dynamic>,
      );
      _updateSavedJobsList(
        ctx,
        isSave: true,
        job: job,
      );
      return job;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
    } finally {
      setSavedUnsavedJob(false);
    }
  }

  Future<StandardTalentJobModel?> unSaveJob(
    BuildContext ctx,
    dynamic payload,
  ) async {
    setSavedUnsavedJob(true);
    try {
      ApiResponse response = await _dashboardService.unSaveJob(ctx, payload);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return null;
      }
      StandardTalentJobModel job = StandardTalentJobModel.fromJson(
        response.result as Map<String, dynamic>,
      );
      _updateSavedJobsList(
        ctx,
        isSave: false,
        job: job,
      );
      return job;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return null;
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
        showError(message: response.message);
        return false;
      }
      setSavedJobs(_resolvePaginatedStandardTalentJobs(response));
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
        showError(message: response.message);
        return false;
      }
      setAppliedJobList(_resolvePaginatedStandardTalentJobs(response));
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
        showError(message: response.message);
        return false;
      }
      setMyCreatedJobList(_resolvePaginatedBusinessJobs(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingAllCreatedJobs(false);
    }
  }

// Trending
  Future<bool> fetchTrending(BuildContext ctx) async {
    setFetchingTrending(true);
    try {
      ApiResponse response = await _dashboardService.fetchTrending(ctx);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      setTrendingList(
        const TrendingModel().fromList(response.result as List<dynamic>),
      );
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingTrending(false);
    }
  }

// Movie Shows
  Future<bool> fetchMovieShows(BuildContext ctx) async {
    setFetchingMovieShows(true);
    try {
      ApiResponse response = await _dashboardService.fetchMovieShows(ctx);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      setMovieShowList(_resolvePaginatedMovieShows(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingMovieShows(false);
    }
  }

// Handling Paginated Data...
// Jobs
  List<BusinessJobModel> _resolvePaginatedBusinessJobs(ApiResponse response) {
    CustomPage<BusinessJobModel> p = const CustomPage<BusinessJobModel>()
        .fromJson(
            response.result as Map<String, dynamic>, const BusinessJobModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<BusinessJobModel>;
    }
    return [];
  }

  List<StandardTalentJobModel> _resolvePaginatedStandardTalentJobs(
      ApiResponse response) {
    CustomPage<StandardTalentJobModel> p =
        const CustomPage<StandardTalentJobModel>().fromJson(
            response.result as Map<String, dynamic>,
            const StandardTalentJobModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<StandardTalentJobModel>;
    }
    return [];
  }

// Events
  List<EventModel> _resolvePaginatedEvents(ApiResponse response) {
    CustomPage<EventModel> p = const CustomPage<EventModel>()
        .fromJson(response.result as Map<String, dynamic>, const EventModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<EventModel>;
    }
    return [];
  }

  List<StandardTalentEventModel> _resolvePaginatedStandardTalentEvents(
      ApiResponse response) {
    CustomPage<StandardTalentEventModel> p =
        const CustomPage<StandardTalentEventModel>().fromJson(
            response.result as Map<String, dynamic>,
            const StandardTalentEventModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<StandardTalentEventModel>;
    }
    return [];
  }

// Projects
  List<ProjectModel> _resolvePaginatedProjects(ApiResponse response) {
    CustomPage<ProjectModel> p = const CustomPage<ProjectModel>().fromJson(
        response.result as Map<String, dynamic>, const ProjectModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<ProjectModel>;
    }
    return [];
  }

// MovieShow
  List<MovieShowModel> _resolvePaginatedMovieShows(ApiResponse response) {
    CustomPage<MovieShowModel> p = const CustomPage<MovieShowModel>().fromJson(
        response.result as Map<String, dynamic>, const MovieShowModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<MovieShowModel>;
    }
    return [];
  }
}
