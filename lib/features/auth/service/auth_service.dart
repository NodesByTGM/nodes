// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/features/auth/repo/auth_repository.dart';

class AuthService {
  final log = Logger('AuthService');

  final AuthRepository authRepository;

  AuthService(this.authRepository);

  final localStorageService = locator.get<LocalStorageService>();

  // Functions
  Future<ApiResponse> login(payload) async {
    try {
      ApiResponse res = await authRepository.login(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @login User ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
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
      ApiResponse res = await authRepository.refreshToken(payload);
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

  Future<ApiResponse> changePassword(payload) async {
    try {
      ApiResponse res = await authRepository.changePassword(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @changePassword ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> logout() async {
    try {
      ApiResponse res = await authRepository.logout();
      return res;
    } on DioException catch (e) {
      log.severe("Error message @logout ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }
  

  Future<ApiResponse> individualOnboarding(payload) async {
    try {
      ApiResponse res = await authRepository.individualOnboarding(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @individualOnboarding ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> talentOnboarding(payload) async {
    try {
      ApiResponse res = await authRepository.talentOnboarding(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @talentOnboarding ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> businessOnboarding(payload) async {
    try {
      ApiResponse res = await authRepository.businessOnboarding(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @businessOnboarding ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchProfile() async {
    try {
      ApiResponse res = await authRepository.fetchProfile();
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchProfile ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> updateProfile(payload) async {
    try {
      ApiResponse res = await authRepository.updateProfile(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @updateProfile ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> talentAccountUpgrade(payload) async {
    try {
      ApiResponse res = await authRepository.talentAccountUpgrade(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @talentAccountUpgrade ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> businessAccountUpgrade(payload) async {
    try {
      ApiResponse res = await authRepository.businessAccountUpgrade(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @businessAccountUpgrade ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> mediaUpload(payload) async {
    try {
      ApiResponse res = await authRepository.mediaUpload(payload);
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

}
