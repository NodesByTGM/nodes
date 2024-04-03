// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/features/community/repo/space_repository.dart';

class SpaceService {
  final log = Logger('SpaceService');

  final SpaceRepository spaceRepository;

  SpaceService(this.spaceRepository);

  final localStorageService = locator.get<LocalStorageService>();

  // Functions
  Future<ApiResponse> createSpace(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.createSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @createSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllSpaces({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await spaceRepository.fetchAllSpaces(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllSpaces ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllMySpaces({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await spaceRepository.fetchAllMySpaces(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllMySpaces ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchSingleSpace(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.fetchSingleSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchSingleSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> updateSingleSpace({required dynamic id, required dynamic payload,}) async {
    try {
      ApiResponse res = await spaceRepository.updateSingleSpace(id,payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @updateSingleSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> joinSpace(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.joinSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @joinSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> leaveSpace(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.leaveSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @leaveSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }
  

  Future<ApiResponse> addMemberToSpace(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.addMemberToSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @addMemberToSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> removeMemberFromSpace(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.removeMemberFromSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @removeMemberFromSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> makeSpaceAdmin(dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.makeSpaceAdmin(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @makeSpaceAdmin ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

}
