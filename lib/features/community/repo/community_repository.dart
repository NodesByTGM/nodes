// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'community_repository.g.dart';

class ComApis {
  static const baseApi = API_ENDPOINT;

  // Projects
  static const projectApi = "$baseApi/projects";

  // Community
  static const postApi = "$baseApi/posts";
  static const singlePost = "$postApi/{id}";
  static const singlePostLike = "$postApi/like/{id}";
  static const singlePostUnlike = "$postApi/unlike/{id}";

  // General Users
  static const usersApi = "$baseApi/users";
  static const singleUsers = "$usersApi/{id}";

  // Connections
  static const connectionApi = "$usersApi/connections";
  static const removeConnection = "$connectionApi/remove/{id}";
  static const singleUserConnections = "$connectionApi/{id}";
  static const allMyConnections = "$connectionApi/mine";
  static const requestConnection = "$connectionApi/request/{id}";
  static const connectionRequestApi = "$connectionApi/requests"; // fetch all
  static const acceptConnectionRequest = "$connectionRequestApi/accept/{id}";
  static const rejectConnectionRequest = "$connectionRequestApi/reject/{id}";
  static const abandonConnectionRequest = "$connectionRequestApi/abandon/{id}";
}

@RestApi()
abstract class ComRepository {
  factory ComRepository(Dio dio, {String? baseUrl}) = _ComRepository;

  @POST(ComApis.projectApi)
  Future<ApiResponse> createProject(@Body() payload);

  @GET(ComApis.projectApi)
  Future<ApiResponse> fetchProject();

  @POST(ComApis.postApi)
  Future<ApiResponse> createPost(
    @Body() payload,
  );

  @GET(ComApis.postApi)
  Future<ApiResponse> fetchAllPosts();

  @GET(ComApis.singlePost)
  Future<ApiResponse> fetchSinglePost(
    @Path('id') String id,
  );

  @POST(ComApis.singlePostLike)
  Future<ApiResponse> likeSinglePost(
    @Path('id') String id,
  );

  @POST(ComApis.singlePostUnlike)
  Future<ApiResponse> unlikeSinglePost(
    @Path('id') String id,
  );

  @GET(ComApis.usersApi)
  Future<ApiResponse> fetchAllUsers();

  @GET(ComApis.singleUsers)
  Future<ApiResponse> fetchSingleUser(
    @Path('id') String id,
  );
//
  @POST(ComApis.requestConnection)
  Future<ApiResponse> requestConnection(
    @Path('id') String id,
  );

  @GET(ComApis.connectionRequestApi)
  Future<ApiResponse> fetchAllConnections(
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @POST(ComApis.acceptConnectionRequest)
  Future<ApiResponse> acceptConnectionRequest(
    @Path('id') String id,
  );

  @POST(ComApis.abandonConnectionRequest)
  Future<ApiResponse> abandonConnectionRequest(
    @Path('id') String id,
  );

  @POST(ComApis.rejectConnectionRequest)
  Future<ApiResponse> rejectConnectionRequest(
    @Path('id') String id,
  );

  @DELETE(ComApis.removeConnection)
  Future<ApiResponse> removeConnection(
    @Path('id') String id,
  );

  @GET(ComApis.singleUserConnections)
  Future<ApiResponse> fetchSingleUserConnections(
    @Path('id') String id,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @GET(ComApis.allMyConnections)
  Future<ApiResponse> fetchAllMyConnections(
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );
}
