// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
  Future<ApiResponse> createPost(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await comRepository.createPost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @createPost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllPosts(BuildContext ctx,) async {
    try {
      ApiResponse res = await comRepository.fetchAllPosts();
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllPosts ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchSinglePost(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await comRepository.fetchSinglePost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchSinglePost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> likeSinglePost(BuildContext ctx, dynamic payload) async {
    try {
      ApiResponse res = await comRepository.likeSinglePost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @likeSinglePost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> unlikeSinglePost(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await comRepository.unlikeSinglePost(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @unlikeSinglePost ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }
}
