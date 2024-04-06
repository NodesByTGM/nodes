// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
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
  Future<ApiResponse> createEvent(dynamic payload) async {
    try {
      ApiResponse res = await dashboardRepository.createEvent(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @createEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllEvents({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllEvents(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllEvents ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchSingleEvent(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.fetchEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchSingleEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> updateSingleEvent({
    required dynamic id,
    required dynamic payload,
  }) async {
    try {
      ApiResponse res = await dashboardRepository.updateEvent(id, payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @updateSingleEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> deleteSingleEvent(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.deleteEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @deleteSingleEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> saveEvent(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.saveEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @saveEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> unSaveEvent(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.unSaveEvent(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @unSaveEvent ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllSavedEvents({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllSavedEvents(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllSavedEvents ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllAllMyCreatedEvents({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllAllMyCreatedEvents(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllAllMyCreatedEvents ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

// Jobs
  Future<ApiResponse> createJob(dynamic payload) async {
    try {
      ApiResponse res = await dashboardRepository.createJob(payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @createJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllJobs({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchSingleJob(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.fetchJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchSingleJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> updateSingleJob({
    required dynamic id,
    required dynamic payload,
  }) async {
    try {
      ApiResponse res = await dashboardRepository.updateJob(id, payload);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @updateSingleJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> deleteSingleJob(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.deleteJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @deleteSingleJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> applyForJob(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.applyForJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @applyForJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> saveJob(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.saveJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @saveJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> unSaveJob(dynamic id) async {
    try {
      ApiResponse res = await dashboardRepository.unSaveJob(id);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @unSaveJob ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllSavedJobs({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllSavedJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe("Error message @fetchAllSavedJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllAppliedJobs({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllAppliedJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllAppliedJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }

  Future<ApiResponse> fetchAllMyCreatedJobs({required int page, required int pageSize,}) async {
    try {
      ApiResponse res = await dashboardRepository.fetchAllMyCreatedJobs(page, pageSize);
      return res;
    } on DioException catch (e) {
      log.severe(
          "Error message @fetchAllMyCreatedJobs ::===> ${e.response?.data}");
      return NetworkException.errorHandler(e);
    }
  }
}
