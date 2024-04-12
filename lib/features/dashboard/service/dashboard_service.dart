// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/exception/app_exceptions.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/features/dashboard/repo/dashboard_repository.dart';

class DashboardService {
  final log = Logger('DashboardService');

  final DashboardRepository dashboardRepository;

  DashboardService(this.dashboardRepository);

  final localStorageService = locator.get<LocalStorageService>();

  // Functions

  // Events
  Future<ApiResponse> createProject(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await dashboardRepository.createProject(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @createProject ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllProjects(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllProjects(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllProjects ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchMyProjects(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchMyProjects(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchMyProjects ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> createEvent(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await dashboardRepository.createEvent(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @createEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllEvents(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllEvents(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllEvents ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchSingleEvent(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.fetchEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchSingleEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> updateSingleEvent(BuildContext ctx,{
    required dynamic id,
    required dynamic payload,
  }) async {
    try {
      ApiResponse res = await dashboardRepository.updateEvent(id, payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @updateSingleEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> deleteSingleEvent(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.deleteEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @deleteSingleEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> saveEvent(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.saveEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @saveEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> unSaveEvent(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.unSaveEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @unSaveEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllSavedEvents(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllSavedEvents(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllSavedEvents ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllAllMyCreatedEvents(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllAllMyCreatedEvents(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllAllMyCreatedEvents ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

// Jobs
  Future<ApiResponse> createJob(BuildContext ctx,dynamic payload) async {
    try {
      ApiResponse res = await dashboardRepository.createJob(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @createJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllJobs(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchSingleJob(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.fetchJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchSingleJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> updateSingleJob(BuildContext ctx,{
    required dynamic id,
    required dynamic payload,
  }) async {
    try {
      ApiResponse res = await dashboardRepository.updateJob(id, payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @updateSingleJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> deleteSingleJob(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.deleteJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @deleteSingleJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> applyForJob(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.applyForJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @applyForJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> saveJob(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.saveJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @saveJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> unSaveJob(BuildContext ctx,dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.unSaveJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @unSaveJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllSavedJobs(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllSavedJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllSavedJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllAppliedJobs(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllAppliedJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllAppliedJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchAllMyCreatedJobs(BuildContext ctx,{required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllMyCreatedJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllMyCreatedJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }

  Future<ApiResponse> fetchTrending(BuildContext ctx) async {
    try {
      ApiResponse res = await dashboardRepository.fetchTrending();
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchTrending ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e, context: ctx);
    }
  }
}
