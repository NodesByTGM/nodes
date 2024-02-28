// ignore_for_file: non_constant_identifier_names


import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:retrofit/retrofit.dart';

part 'com_repository.g.dart';

class ComApis {
  static const baseApi = API_ENDPOINT;
}

@RestApi()
abstract class ComRepository {
  factory ComRepository(Dio dio, {String? baseUrl}) = _ComRepository;

  // @POST(ComApis.login)
  // Future<ApiResponse> login(@Body() LoginDetails payload);


}
