// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

class AuthApis {
  static const baseApi = API_ENDPOINT;
  static const auth = "$API_ENDPOINT/auth";
  static const register = "$auth/register";
  static const login = "$auth/login";
  static const refreshToken = "$auth/refresh-token";
  static const sendOTP = "$auth/send-otp";
  static const verifyEmail = "$auth/verify-email";
  static const verifyOTP = "$auth/verify-otp";
  static const forgotPassword = "$auth/forgot-password";

  static const resetPassword = "$baseApi/reset-password/{accountId}/{token}";
  static const changePassword = "$baseApi/change-password";
  static const logout = "$baseApi/logout";

  // Onboarding
  static const onboardingApi = "$baseApi/onboarding";
  static const talentOnboarding = "$onboardingApi/talent";
  static const businessOnboarding = "$onboardingApi/business";

  // Profile
  static const profileApi = "$baseApi/users/profile";

  // Upgrades
  static const upgradeApi = "$baseApi/upgrades";
  static const talentAccountUpgradeApi = "$upgradeApi/talent";
  static const businessAccountUpgradeApi = "$upgradeApi/business";

  // Media Uploads
  static const mediaUploadsApi = "$baseApi/uploads/media";
  static const deleteMediaApi = "$mediaUploadsApi/delete/{id}";

  // Paystack
  static const paystackInitialize = "$baseApi/transactions/subscription/initiate";
}

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String? baseUrl}) = _AuthRepository;

  @POST(AuthApis.login)
  Future<ApiResponse> login(@Body() payload);

  @POST(AuthApis.register)
  Future<ApiResponse> register(@Body() payload);

  @POST(AuthApis.refreshToken)
  Future<ApiResponse> refreshToken(@Body() payload);

  @POST(AuthApis.sendOTP)
  Future<ApiResponse> sendOTP(@Body() payload);

  @POST(AuthApis.verifyEmail)
  Future<ApiResponse> verifyEmail(@Body() payload);

  @POST(AuthApis.verifyOTP)
  Future<ApiResponse> verifyOTP(@Body() payload);

  @POST(AuthApis.forgotPassword)
  Future<ApiResponse> forgotPassword(@Body() payload);

  @POST(AuthApis.resetPassword)
  Future<ApiResponse> resetPassword(
    @Path('accountId') String accountId,
    @Path('token') String token,
    @Body() payload,
  );

  @POST(AuthApis.changePassword)
  Future<ApiResponse> changePassword(@Body() payload);

  @POST(AuthApis.logout)
  Future<ApiResponse> logout();

  @POST(AuthApis.onboardingApi)
  Future<ApiResponse> individualOnboarding(@Body() payload);

  @POST(AuthApis.talentOnboarding)
  Future<ApiResponse> talentOnboarding(@Body() payload);

  @POST(AuthApis.businessOnboarding)
  Future<ApiResponse> businessOnboarding(@Body() payload);

  @GET(AuthApis.profileApi)
  Future<ApiResponse> fetchProfile();

  @PUT(AuthApis.profileApi)
  Future<ApiResponse> updateProfile(@Body() payload);

  @POST(AuthApis.talentAccountUpgradeApi)
  Future<ApiResponse> talentAccountUpgrade(@Body() payload);

  @POST(AuthApis.businessAccountUpgradeApi)
  Future<ApiResponse> businessAccountUpgrade(@Body() payload);

  // @MultiPart()
  // @POST(AuthApis.mediaUploadsApi)
  // Future<ApiResponse> mediaUpload(
  //   @Part(name: "file", fileName: "lol.png") File file,
  //   // @Body() payload,
  // );

  @POST(AuthApis.mediaUploadsApi)
  Future<ApiResponse> mediaUpload(
   
    @Body() payload,
  );

  @DELETE(AuthApis.deleteMediaApi)
  Future<ApiResponse> deleteMedia(
    @Path('id') String id,
  );

  @POST(AuthApis.paystackInitialize)
  Future<ApiResponse> getPaystackAuthUrl(
    @Body() CustomPaystackModel payload,
  );
}

