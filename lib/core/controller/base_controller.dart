import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

abstract class BaseController extends ChangeNotifier {
  final baseControllerLog = Logger("BaseController");

// Variables
  bool _busy = false;
  bool _searching = false;
  bool _isVerifyOTP = false;
  bool _isUploadingMedia = false;
  bool _likeUnlikePost = false;
  bool _isFetchingPost = false;
  bool _isFetchingSinglePost = false;
  bool _isFetchingSpaces = false;
  bool _isFetchingSingleSpace = false;
  bool _isUpdatingSingleSpace = false;
  bool _isJoiningSpace = false;
  bool _isLeavingSpace = false;
  bool _isAdingSpace = false;
  bool _isRemovingSpaceMember = false;
  bool _isMakingSpaceAdmin = false;
  bool _isFetchingAllCreatedJobs = false;
  bool _isFetchingAllAppliedJobs = false;
  bool _isFetchingAllSavedJobs = false;
  bool _isSavingUnsavedJobs = false;
  bool _isApplyingForJob = false;
  bool _isDeletingJob = false;
  bool _isUpdatingJob = false;
  bool _isFetchingSingleJob = false;
  bool _isFetchingAllJob = false;
  bool _isCreatingJob = false;
  bool _isFetchingAllCreatedEvents = false;
  bool _isFetchingAllAppliedEvents = false;
  bool _isFetchingAllSavedEvents = false;
  bool _isSavingUnsavedEvent = false;
  bool _isDeletingEvent = false;
  bool _isUpdatingEvent = false;
  bool _isFetchingSingleEvent = false;
  bool _isFetchingAllEvent = false;
  bool _isCreatingEvent = false;
  bool _isCreatingProject = false;
  bool _isFetchingAllProjects = false;
  bool _isFetchMyProjects = false;
  bool _isFetchTrending = false;
  bool _isFetchMovieShows = false;
  

// Getters
  bool get loading => _busy;
  bool get searching => _searching;
  bool get verifyOTPStatus => _isVerifyOTP;
  bool get isUploadingMedia => _isUploadingMedia;
  bool get likeUnlikePost => _likeUnlikePost;
  bool get isFetchingPost => _isFetchingPost;
  bool get isFetchingSinglePost => _isFetchingSinglePost;
  bool get isFetchingSpaces => _isFetchingSpaces;
  bool get isFetchingSingleSpace => _isFetchingSingleSpace;
  bool get isUpdatingSingleSpace => _isUpdatingSingleSpace;
  bool get isJoiningSpace => _isJoiningSpace;
  bool get isLeavingSpace => _isLeavingSpace;
  bool get isAdingSpace => _isAdingSpace;
  bool get isRemovingSpaceMember => _isRemovingSpaceMember;
  bool get isMakingSpaceAdmin => _isMakingSpaceAdmin;
  bool get isFetchingAllCreatedJobs => _isFetchingAllCreatedJobs;
  bool get isFetchingAllAppliedJobs => _isFetchingAllAppliedJobs;
  bool get isFetchingAllSavedJobs => _isFetchingAllSavedJobs;
  bool get isSavingUnsavedJobs => _isSavingUnsavedJobs;
  bool get isApplyingForJob => _isApplyingForJob;
  bool get isDeletingJob => _isDeletingJob;
  bool get isUpdatingJob => _isUpdatingJob;
  bool get isFetchingSingleJob => _isFetchingSingleJob;
  bool get isFetchingAllJob => _isFetchingAllJob;
  bool get isCreatingJob => _isCreatingJob;
  bool get isFetchingAllCreatedEvents => _isFetchingAllCreatedEvents;
  bool get isFetchingAllAppliedEvents => _isFetchingAllAppliedEvents;
  bool get isFetchingAllSavedEvents => _isFetchingAllSavedEvents;
  bool get isSavingUnsavedEvent => _isSavingUnsavedEvent;
  bool get isDeletingEvent => _isDeletingEvent;
  bool get isUpdatingEvent => _isUpdatingEvent;
  bool get isFetchingSingleEvent => _isFetchingSingleEvent;
  bool get isFetchingAllEvent => _isFetchingAllEvent;
  bool get isCreatingEvent => _isCreatingEvent;
  bool get isCreatingProject => _isCreatingProject;
  bool get isFetchingAllProjects => _isFetchingAllProjects;
  bool get isFetchMyProjects => _isFetchMyProjects;
  bool get isFetchTrending => _isFetchTrending;
  bool get isFetchMovieShows => _isFetchMovieShows;


  // Setters
  setBusy(bool value, {bool when = true}) {
    if (!when) {
      return;
    }
    _busy = value;
    notifyListeners();
  }

  setSearching(bool value) {
    _searching = value;
    notifyListeners();
  }

  setVerifyOTP(bool value) {
    _isVerifyOTP = value;
    notifyListeners();
  }

  setUploadingMedia(bool value) {
    _isUploadingMedia = value;
    notifyListeners();
  }

  setLikeUnlikePost(bool value) {
    _likeUnlikePost = value;
    notifyListeners();
  }

  setFetchPost(bool value) {
    _isFetchingPost = value;
    notifyListeners();
  }

  setFetchSinglePost(bool value) {
    _isFetchingSinglePost = value;
    notifyListeners();
  }

  setFetchSpace(bool value) {
    _isFetchingSpaces = value;
    notifyListeners();
  }

  setFetchSingleSpace(bool value) {
    _isFetchingSingleSpace = value;
    notifyListeners();
  }

  //
  setUpdatingSingleSpace(bool value) {
    _isUpdatingSingleSpace = value;
    notifyListeners();
  }

  setJoinSpace(bool value) {
    _isJoiningSpace = value;
    notifyListeners();
  }

  setLeaveSpace(bool value) {
    _isLeavingSpace = value;
    notifyListeners();
  }

  setAddSpaceMember(bool value) {
    _isAdingSpace = value;
    notifyListeners();
  }

  setRemoveSpaceMember(bool value) {
    _isRemovingSpaceMember = value;
    notifyListeners();
  }

  setMakeSpaceAdmin(bool value) {
    _isMakingSpaceAdmin = value;
    notifyListeners();
  }

//
  setFetchingAllCreatedJobs(bool value) {
    _isFetchingAllCreatedJobs = value;
    notifyListeners();
  }

  setFetchingAllAppliedJobs(bool value) {
    _isFetchingAllAppliedJobs = value;
    notifyListeners();
  }

  setFetchingAllSavedJobs(bool value) {
    _isFetchingAllSavedJobs = value;
    notifyListeners();
  }

  setSavedUnsavedJob(bool value) {
    _isSavingUnsavedJobs = value;
    notifyListeners();
  }

  setApplyingForJob(bool value) {
    _isApplyingForJob = value;
    notifyListeners();
  }

  setDeleteJob(bool value) {
    _isDeletingJob = value;
    notifyListeners();
  }

  setUpdatingJob(bool value) {
    _isUpdatingJob = value;
    notifyListeners();
  }

  setFetchingSingleJob(bool value) {
    _isFetchingSingleJob = value;
    notifyListeners();
  }

  setFetchingAllJobs(bool value) {
    _isFetchingAllJob = value;
    notifyListeners();
  }

  setCreatingJob(bool value) {
    _isCreatingJob = value;
    notifyListeners();
  }

//
  setFetchingAllCreatedEvents(bool value) {
    _isFetchingAllCreatedEvents = value;
    notifyListeners();
  }

  setFetchingAllAppliedEvents(bool value) {
    _isFetchingAllAppliedEvents = value;
    notifyListeners();
  }

  setFetchingAllSavedEvents(bool value) {
    _isFetchingAllSavedEvents = value;
    notifyListeners();
  }

  setSavedUnsavedEvent(bool value) {
    _isSavingUnsavedEvent = value;
    notifyListeners();
  }

  setDeleteEvent(bool value) {
    _isDeletingEvent = value;
    notifyListeners();
  }

  setUpdatingEvent(bool value) {
    _isUpdatingEvent = value;
    notifyListeners();
  }

  setFetchingSingleEvent(bool value) {
    _isFetchingSingleEvent = value;
    notifyListeners();
  }

  setFetchingAllEvents(bool value) {
    _isFetchingAllEvent = value;
    notifyListeners();
  }

  setCreatingEvent(bool value) {
    _isCreatingEvent = value;
    notifyListeners();
  }

  setCreatingProject(bool value) {
    _isCreatingProject = value;
    notifyListeners();
  }

  setFetchingAllProjects(bool value) {
    _isFetchingAllProjects = value;
    notifyListeners();
  }

  setFetchingMyProjects(bool value) {
    _isFetchMyProjects = value;
    notifyListeners();
  }

  setFetchingTrending(bool value) {
    _isFetchTrending = value;
    notifyListeners();
  }

  setFetchingMovieShows(bool value) {
    _isFetchMovieShows = value;
    notifyListeners();
  }
}
