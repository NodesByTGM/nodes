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
  static const communityApi = "$baseApi/community";
  static const communityPost = "$communityApi/posts/";
  static const singleCommunityPost = "$communityApi/posts/{id}";
  static const singleCommunityPostLike = "$communityApi/posts/like/{id}";
  static const singleCommunityPostUnlike = "$communityApi/posts/unlike/{id}";
}

@RestApi()
abstract class ComRepository {
  factory ComRepository(Dio dio, {String? baseUrl}) = _ComRepository;

  @POST(ComApis.projectApi)
  Future<ApiResponse> createProject(@Body() payload);

  @GET(ComApis.projectApi)
  Future<ApiResponse> fetchProject();

  @POST(ComApis.communityPost)
  Future<ApiResponse> createCommunityPost(
    @Body() payload,
  );

  @GET(ComApis.communityPost)
  Future<ApiResponse> fetchAllCommunityPosts();

  @GET(ComApis.singleCommunityPost)
  Future<ApiResponse> fetchSingleCommunityPost(
    @Path('id') String id,
  );

  @POST(ComApis.singleCommunityPostLike)
  Future<ApiResponse> likeSingleCommunityPost(
    @Path('id') String id,
  );

  @POST(ComApis.singleCommunityPostLike)
  Future<ApiResponse> unlikeSingleCommunityPost(
    @Path('id') String id,
  );
}
