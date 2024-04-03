// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/features/community/repo/community_repository.dart';

class ComService {
  final log = Logger('ComService');

  final ComRepository comRepository;

  ComService(this.comRepository);

  final localStorageService = locator.get<LocalStorageService>();

  // Functions
  Future<ApiResponse> createCommunityPost(dynamic payload) async {
    try {
      ApiResponse res = await comRepository.createCommunityPost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @createCommunityPost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllCommunityPosts() async {
    try {
      ApiResponse res = await comRepository.fetchAllCommunityPosts();
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllCommunityPosts ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchSingleCommunityPost(dynamic payload) async {
    try {
      ApiResponse res = await comRepository.fetchSingleCommunityPost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchSingleCommunityPost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> likeSingleCommunityPost(dynamic payload) async {
    try {
      ApiResponse res = await comRepository.likeSingleCommunityPost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @likeSingleCommunityPost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> unlikeSingleCommunityPost(dynamic payload) async {
    try {
      ApiResponse res = await comRepository.unlikeSingleCommunityPost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @unlikeSingleCommunityPost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }
}
