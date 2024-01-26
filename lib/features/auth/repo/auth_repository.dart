// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

class AuthApis {
  static const baseApi = API_ENDPOINT;
  static const auth = "$API_ENDPOINT/auth";
  static const refreshToken = "$auth/refresh/";
  static const login = "$auth/login/";
  static const userSignup = "$auth/signup/";
  static const verifyOtp = "$auth/verify/";
}

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String? baseUrl}) = _AuthRepository;

  // @POST(AuthApis.login)
  // Future<ApiResponse> login(@Body() LoginDetails payload);


  // @MultiPart()
  // @POST(AuthApis.manageSecurity)
  // Future<ApiResponse> createSecurity(
  //   @Part(name: "identification_photo", fileName: "lol.png") File identification_photo,
  //   @Part(name: "nin") String nin,
  //   @Part(name: "active_from") String active_from,
  //   @Part(name: "active_to") String active_to,
  //   @Part(name: "phone_no") String phone_no,
  //   @Part(name: "first_name") String first_name,
  //   @Part(name: "last_name") String last_name,
  //   @Part(name: "email") String email, {
  //   @SendProgress() ProgressCallback? onSendProgress,
  // });

}
