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
}

@RestApi()
abstract class ComRepository {
  factory ComRepository(Dio dio, {String? baseUrl}) = _ComRepository;

  @POST(ComApis.projectApi)
  Future<ApiResponse> createProject(@Body() payload);

  @GET(ComApis.projectApi)
  Future<ApiResponse> fetchProject();
}
