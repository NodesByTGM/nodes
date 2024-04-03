import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

abstract class BaseController extends ChangeNotifier {
  final baseControllerLog = Logger("BaseController");

// Variables
  bool _busy = false;
  bool _searching = false;
  bool _isVerifyOTP = false;
  bool _isUploadingMedia = false;
  bool _likeUnlikecommunityPost = false;
  bool _isFetchingCommunityPost = false;
  bool _isFetchingSingleCommunityPost = false;
  bool _isFetchingSpaces = false;
  bool _isFetchingSingleSpace = false;
  bool _isUpdatingSingleSpace = false;
  bool _isJoiningSpace = false;
  bool _isLeavingSpace = false;
  bool _isAdingSpace = false;
  bool _isRemovingSpaceMember = false;
  bool _isMakingSpaceAdmin = false;

  

// Getters
  bool get loading => _busy;
  bool get searching => _searching;
  bool get verifyOTPStatus => _isVerifyOTP;
  bool get isUploadingMedia => _isUploadingMedia;
  bool get likeUnlikecommunityPost => _likeUnlikecommunityPost;
  bool get isFetchingCommunityPost => _isFetchingCommunityPost;
  bool get isFetchingSingleCommunityPost => _isFetchingSingleCommunityPost;
  bool get isFetchingSpaces => _isFetchingSpaces;
  bool get isFetchingSingleSpace => _isFetchingSingleSpace;
  bool get isUpdatingSingleSpace => _isUpdatingSingleSpace;
  bool get isJoiningSpace => _isJoiningSpace;
  bool get isLeavingSpace => _isLeavingSpace;
  bool get isAdingSpace => _isAdingSpace;
  bool get isRemovingSpaceMember => _isRemovingSpaceMember;
  bool get isMakingSpaceAdmin => _isMakingSpaceAdmin;

  

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

  setLikeUnlikecommunityPost(bool value) {
    _likeUnlikecommunityPost = value;
    notifyListeners();
  }

  setFetchCommunityPost(bool value) {
    _isFetchingCommunityPost = value;
    notifyListeners();
  }

  setFetchSingleCommunityPost(bool value) {
    _isFetchingSingleCommunityPost = value;
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
}
