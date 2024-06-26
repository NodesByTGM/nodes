// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/features/auth/models/paystack_auth_url_model.dart';
import 'package:nodes/features/auth/repo/auth_repository.dart';

class AuthService {
  final log = Logger('AuthService');

  final AuthRepository authRepository;

  AuthService(this.authRepository);

  final localStorageService = locator.get<LocalStorageService>();

  // Functions
  Future<ApiResponse> login(BuildContext ctx, payload) async {
    try {
      ApiResponse res = await authRepository.login(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @login User ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> register(payload) async {
    try {
      ApiResponse res = await authRepository.register(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @register ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> refreshToken(payload) async {
    try {
      ApiResponse res = await authRepository.refreshToken({
        "refreshToken": payload,
      });
      return res;
    } on DioException catch (e) {
      log.severe("Error message @refreshToken ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> sendOTP(payload) async {
    try {
      ApiResponse res = await authRepository.sendOTP(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @sendOTP ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> verifyEmail(payload) async {
    try {
      ApiResponse res = await authRepository.verifyEmail(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @verifyEmail ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> verifyOTP(payload) async {
    try {
      ApiResponse res = await authRepository.verifyOTP(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @verifyOTP ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> forgotPassword(payload) async {
    try {
      ApiResponse res = await authRepository.forgotPassword(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @forgotPassword ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> resetPassword({
    required dynamic id,
    required dynamic token,
    required dynamic payload,
  }) async {
    try {
      ApiResponse res = await authRepository.resetPassword(id, token, payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @resetPassword ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> changePassword(BuildContext ctx, payload) async {
    try {
      ApiResponse res = await authRepository.changePassword(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @changePassword ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> logout(BuildContext ctx) async {
    try {
      ApiResponse res = await authRepository.logout();
      return res;
    } on DioException catch (e) {
      log.severe("Error message @logout ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> onboarding(payload) async {
    try {
      ApiResponse res = await authRepository.onboarding(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @onboarding ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> verifyBusiness(payload) async {
    try {
      ApiResponse res = await authRepository.verifyBusiness(payload);
      return res;
    } on DioException catch (e) {
      // log.severe("Error message @verifyBusiness ::===> ${e.response?.data}");
      log.severe("Error message @verifyBusiness ::===> ${e.response}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchProfile(BuildContext ctx) async {
    try {
      ApiResponse res = await authRepository.fetchProfile();
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchProfile ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> updateProfile(BuildContext ctx, payload) async {
    try {
      ApiResponse res = await authRepository.updateProfile(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @updateProfile ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> updateBusinessProfile(BuildContext ctx, payload) async {
    try {
      ApiResponse res = await authRepository.updateBusinessProfile(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @updateBusinessProfile ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  // Future<ApiResponse> mediaUpload(File file) async {
  //   try {
  //     ApiResponse res = await authRepository.mediaUpload(file);
  //     return res;
  //   } on DioException catch (e) {
  //     log.severe("Error message @mediaUpload ::===> ${e.response?.data}");
  //     return NetworkException.errorHandler(e);
  //   }
  // }

  Future<ApiResponse> mediaUpload(dynamic file) async {
    try {
      ApiResponse res = await authRepository.mediaUpload(file);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @mediaUpload ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> deleteMedia(id) async {
    try {
      ApiResponse res = await authRepository.deleteMedia(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @deleteMedia ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> getPaystackAuthUrl(
      BuildContext ctx, CustomPaystackModel payload) async {
    try {
      ApiResponse res = await authRepository.getPaystackAuthUrl(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @getPaystackAuthUrl ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> verifyAndUpgradeSubscription(dynamic payload) async {
    try {
      ApiResponse res =
          await authRepository.verifyAndUpgradeSubscription(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @verifyAndUpgradeSubscription ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllMyTransactions() async {
    try {
      ApiResponse res = await authRepository.fetchAllMyTransactions();
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllMyTransactions ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }
}
