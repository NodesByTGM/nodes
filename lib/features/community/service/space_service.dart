// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  Future<ApiResponse> createSpace(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.createSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @createSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllSpaces(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await spaceRepository.fetchAllSpaces(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllSpaces ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllMySpaces(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await spaceRepository.fetchAllMySpaces(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllMySpaces ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchSingleSpace(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.fetchSingleSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchSingleSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> updateSingleSpace(BuildContext ctx,{required dynamic id, required dynamic payload,}) async {
    try {
      ApiResponse res = await spaceRepository.updateSingleSpace(id,payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @updateSingleSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> joinSpace(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.joinSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @joinSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> leaveSpace(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.leaveSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @leaveSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }
  

  Future<ApiResponse> addMemberToSpace(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.addMemberToSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @addMemberToSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> removeMemberFromSpace(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.removeMemberFromSpace(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @removeMemberFromSpace ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> makeSpaceAdmin(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await spaceRepository.makeSpaceAdmin(payload);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @makeSpaceAdmin ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

}
