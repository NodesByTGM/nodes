// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously

import 'package:logging/logging.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/models/custom_page.dart';
import 'package:nodes/features/auth/models/user_connection_model.dart';
import 'package:nodes/features/auth/models/user_model.dart';
import 'package:nodes/features/community/models/community_post_model.dart';
import 'package:nodes/features/community/models/create_post_model.dart';
import 'package:nodes/features/community/models/currently_viewed_user_model.dart';
import 'package:nodes/features/community/models/general_user_model.dart';
import 'package:nodes/features/community/service/community_service.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

class ComController extends BaseController {
  final log = Logger('ComController');
  final ComService _comService;

  ComController(this._comService);

  // <================= Variables Starts here =================>
  // This should somehow have the description to denote if it was created by the user or not in the model.
  dynamic _currentlyViewedSpace = "";
  CurrentlyViewedUser _currentlyViewedUser = const CurrentlyViewedUser();
  bool _dummyIsCreatedSpace = false;
  List<PostModel> _postList = [];
  List<CreatePostModel> _draftPostList = [];
  //General Users
  List<GeneralUserModel> _generalUsers = [];

  // <================= Getters Starts here =====================>
  get currentlyViewedSpace => _currentlyViewedSpace;
  CurrentlyViewedUser get currentlyViewedUser => _currentlyViewedUser;
  bool get dummyIsCreatedSpace => _dummyIsCreatedSpace;
  List<PostModel> get postList => _postList;
  List<CreatePostModel> get draftPostList => _draftPostList;
  List<GeneralUserModel> get generalUsers => _generalUsers;

  // <================= Setters Starts here =================>

  setCurrentlyViewedSpaceVal(dynamic val) {
    _currentlyViewedSpace = val;
    notifyListeners();
  }

  setCurrentlyViewedUser(CurrentlyViewedUser cUser) {
    _currentlyViewedUser = cUser;
    notifyListeners();
  }

  setDummyIsCreatedSpaceVal(bool val) {
    _dummyIsCreatedSpace = val;
    notifyListeners();
  }

  setPosts(List<PostModel> list) {
    _postList = list;
    notifyListeners();
  }

  setDraftPost(CreatePostModel post) {
    _draftPostList.insert(0, post);
    notifyListeners();
  }

  updatePostData(PostModel post) {
    // Fetching the ID of the post
    int index = _postList.indexWhere((e) => e.id == post.id);
    if (index > -1) {
      //  i.e, found something...
      _postList[index] = post;
      notifyListeners();
    } else {
      showError(message: "Oops!!! Post does not exist again");
    }
  }

  // set currentUserVal(CurrentSession session) {
  //   notifyListeners();
  // }

  // General Users
  setGeneralUsers(List<GeneralUserModel> users) {
    _generalUsers = users;
    notifyListeners();
  }

  resetComCtrl() {
    _currentlyViewedUser = const CurrentlyViewedUser();
    notifyListeners();
  }

  // <================= Functions Starts here =================>
  Future<bool> createPost(BuildContext ctx, CreatePostModel details) async {
    setCreatingPost(true);
    try {
      ApiResponse response =
          await _comService.createPost(ctx, details.toJson());
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      _postList.insert(
        0,
        PostModel.fromJson(response.result as Map<String, dynamic>),
      );
      return true;
    } on NetworkException catch (e) {
      // If an error occurs, send the data to draft folder...
      setDraftPost(details);
      showError(message: e.toString());
      return false;
    } finally {
      setCreatingPost(false);
    }
  }

  Future<bool> fetchAllPosts(
    BuildContext ctx,
  ) async {
    setFetchPost(true);
    try {
      ApiResponse response = await _comService.fetchAllPosts(ctx);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      setPosts(_resolvePaginatedPosts(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchPost(false);
    }
  }

  Future<bool> fetchSinglePost(BuildContext ctx, dynamic details) async {
    setFetchSinglePost(true);
    try {
      ApiResponse response = await _comService.fetchSinglePost(ctx, details);
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
      setFetchSinglePost(false);
    }
  }

  Future<bool> likeSinglePost(BuildContext ctx, PostModel details) async {
    setLikeUnlikePost(true);
    try {
      // This will update the data, whilst waiting for the network feedback, hence emulating the fast update...
      updatePostData(details);
      ApiResponse response = await _comService.likeSinglePost(ctx, details.id);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      updatePostData(
          PostModel.fromJson(response.result as Map<String, dynamic>));
      // This returns the data for post, so use it to update the postList arr...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setLikeUnlikePost(false);
    }
  }

  Future<bool> unlikeSinglePost(BuildContext ctx, PostModel details) async {
    setLikeUnlikePost(true);
    try {
      // This will update the data, whilst waiting for the network feedback, hence emulating the fast update...
      updatePostData(details);
      ApiResponse response =
          await _comService.unlikeSinglePost(ctx, details.id);
      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      updatePostData(
          PostModel.fromJson(response.result as Map<String, dynamic>));
      // This returns the data for post, so use it to update the postList arr...
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setLikeUnlikePost(false);
    }
  }

  // General Users
  Future<bool> fetchAllUsers(BuildContext ctx) async {
    setFetchingGeneralUser(true);
    try {
      ApiResponse response = await _comService.fetchAllUsers(ctx);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      print("George here is the res fo response: ${response.result}");
      setGeneralUsers(_resolvePaginatedUsers(response));
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setFetchingGeneralUser(false);
    }
  }

  Future<UserModel?> fetchSingleUser(BuildContext ctx, String id) async {
    setFetchingSingleGeneralUser(true);
    try {
      ApiResponse response = await _comService.fetchSingleUser(ctx, id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        customNavigateBack(ctx);
        return null;
      }
      return UserModel.fromJson(response.result as Map<String, dynamic>);
    } on NetworkException catch (e) {
      customNavigateBack(ctx);
      showError(message: e.toString());
      return null;
    } finally {
      setFetchingSingleGeneralUser(false);
    }
  }

  //

  Future<bool> requestConnection(BuildContext ctx, String id) async {
    setIsRequestingConnection(true);
    try {
      ApiResponse response = await _comService.requestConnection(ctx, id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsRequestingConnection(false);
    }
  }

  Future<bool> fetchAllConnections(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setIsFetchingAllConnections(true);
    try {
      ApiResponse response = await _comService.fetchAllConnections(
        ctx,
        page: page,
        pageSize: pageSize,
      );

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      // _resolvePaginatedConnections(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsFetchingAllConnections(false);
    }
  }

  Future<bool> acceptConnectionRequest(BuildContext ctx, String id) async {
    setIsAcceptingConnection(true);
    try {
      ApiResponse response = await _comService.acceptConnectionRequest(ctx, id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsAcceptingConnection(false);
    }
  }

  Future<bool> abandonConnectionRequest(BuildContext ctx, String id) async {
    setIsAbandoningConnection(true);
    try {
      ApiResponse response =
          await _comService.abandonConnectionRequest(ctx, id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsAbandoningConnection(false);
    }
  }

  Future<bool> rejectConnectionRequest(BuildContext ctx, String id) async {
    setIsRejectingConnection(true);
    try {
      ApiResponse response = await _comService.rejectConnectionRequest(ctx, id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsRejectingConnection(false);
    }
  }

  Future<bool> removeConnection(BuildContext ctx, String id) async {
    setIsRemovingConnection(true);
    try {
      ApiResponse response = await _comService.removeConnection(ctx, id);

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsRemovingConnection(false);
    }
  }

  Future<bool> fetchSingleUserConnections(
    BuildContext ctx, {
    required String id,
    int page = 1,
    int pageSize = 1000,
  }) async {
    setIsFetchingSingleUserConnection(true);
    try {
      ApiResponse response = await _comService.fetchSingleUserConnections(
        ctx,
        page: page,
        pageSize: pageSize,
        id: id,
      );

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      // _resolvePaginatedConnections(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsFetchingSingleUserConnection(false);
    }
  }

  Future<bool> fetchAllMyConnections(
    BuildContext ctx, {
    int page = 1,
    int pageSize = 1000,
  }) async {
    setIsFetchingAllMyConnection(true);
    try {
      ApiResponse response = await _comService.fetchAllMyConnections(
        ctx,
        page: page,
        pageSize: pageSize,
      );

      if (response.status == KeyString.failure) {
        showError(message: response.message);
        return false;
      }
      // TODO::::
      // _resolvePaginatedConnections(response);
      return true;
    } on NetworkException catch (e) {
      showError(message: e.toString());
      return false;
    } finally {
      setIsFetchingAllMyConnection(false);
    }
  }

// Handling Paginated Data...
  List<PostModel> _resolvePaginatedPosts(ApiResponse response) {
    CustomPage<PostModel> p = const CustomPage<PostModel>()
        .fromJson(response.result as Map<String, dynamic>, const PostModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<PostModel>;
    }
    return [];
  }

  // General Users
  List<GeneralUserModel> _resolvePaginatedUsers(ApiResponse response) {
    CustomPage<GeneralUserModel> p = const CustomPage<GeneralUserModel>()
        .fromJson(
            response.result as Map<String, dynamic>, const GeneralUserModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<GeneralUserModel>;
    }
    return [];
  }

  // Connection
  List<UserConnectionModel> _resolvePaginatedConnections(ApiResponse response) {
    CustomPage<UserConnectionModel> p = const CustomPage<UserConnectionModel>()
        .fromJson(response.result as Map<String, dynamic>,
            const UserConnectionModel());

    if (!isObjectEmpty(p.items)) {
      return p.items as List<UserConnectionModel>;
    }
    return [];
  }
}
