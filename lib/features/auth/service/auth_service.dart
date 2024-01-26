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
  // Future<ApiResponse> login(LoginDetails payload) async {
  //   try {
  //     ApiResponse res = await authRepository.login(payload);
  //     return res;
  //   } on DioException catch (e) {
  //     log.severe("Error message @login User ::===> ${e.response?.data}");
  //     return NetworkException.errorHandler(e);
  //   }
  // }

  // Future<ApiResponse> createSecurity({
  //   required File identification_photo,
  //   required String nin,
  //   required String active_from,
  //   required String active_to,
  //   required String phone_no,
  //   required String first_name,
  //   required String last_name,
  //   required String email,
  // }) async {
  //   try {
  //     ApiResponse res = await authRepository.createSecurity(
  //       identification_photo,
  //       nin,
  //       active_from,
  //       active_to,
  //       phone_no,
  //       first_name,
  //       last_name,
  //       email,
  //       onSendProgress: (sent, total) {
  //         print("Amount of Data sent: $sent and total: $total");
  //         // setState(() {
  //         //   _uploadProgress = "${(sent / total) * 100}%";
  //         // });
  //       },
  //     );
  //     return res;
  //   } on DioException catch (e) {
  //     log.severe("Error message @createSecurity ::===> ${e.response?.data}");
  //     return NetworkException.errorHandler(e);
  //   }
  // }
}
