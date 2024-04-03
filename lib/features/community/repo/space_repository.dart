// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'space_repository.g.dart';

class SpaceApis {
  static const baseApi = API_ENDPOINT;

  // Space
  static const spaceApi = "$baseApi/spaces";
  static const createSpace = "$spaceApi/";
  static const myPersonalSpace = "$spaceApi/mine/";
  static const singleSpace = "$spaceApi/{id}";
  static const joinSpace = "$spaceApi/join/{id}";
  static const leaveSpace = "$spaceApi/leave/{id}";
  static const addMemberToSpace = "$spaceApi/add-member/{id}";
  static const removeMemberFromSpace = "$spaceApi/remove-member/{id}";
  static const makeSpaceAdmin = "$spaceApi/make-admin/{id}";
}

@RestApi()
abstract class SpaceRepository {
  factory SpaceRepository(Dio dio, {String? baseUrl}) = _SpaceRepository;

  @POST(SpaceApis.spaceApi)
  Future<ApiResponse> createSpace(
    @Body() payload,
  );

  @GET(SpaceApis.createSpace)
  Future<ApiResponse> fetchAllSpaces(
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @GET(SpaceApis.myPersonalSpace)
  Future<ApiResponse> fetchAllMySpaces(
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @PUT(SpaceApis.singleSpace)
  Future<ApiResponse> updateSingleSpace(
    @Path('id') String id,
    @Body() dynamic payload,
  );

  @GET(SpaceApis.singleSpace)
  Future<ApiResponse> fetchSingleSpace(
    @Path('id') String id,
  );

  @POST(SpaceApis.joinSpace)
  Future<ApiResponse> joinSpace(
    @Path('id') String id,
  );
  

  @POST(SpaceApis.leaveSpace)
  Future<ApiResponse> leaveSpace(
    @Path('id') String id,
  );
  

  @POST(SpaceApis.addMemberToSpace)
  Future<ApiResponse> addMemberToSpace(
    @Path('id') String id,
  );

  @POST(SpaceApis.removeMemberFromSpace)
  Future<ApiResponse> removeMemberFromSpace(
    @Path('id') String id,
  );

  @POST(SpaceApis.makeSpaceAdmin)
  Future<ApiResponse> makeSpaceAdmin(
    @Path('id') String id,
  );

}
