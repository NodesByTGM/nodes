import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/auth/views/welcome_back_screen.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:nodes/utilities/utils/utils.dart';
import 'package:nodes/core/models/api_response.dart';

class NetworkException implements Exception {
  final dynamic msg;

  NetworkException([this.msg]);

  @override
  String toString() => "$msg";

  static ApiResponse errorHandler(DioException e, {BuildContext? context}) {
    if (!isObjectEmpty(e.response)) {
      if (e.response?.statusCode == 401) {
        // UnAuthorized
        // Call the refreshToken function from your auth provider and handle it accordingly
        context?.read<AuthController>().refreshToken();
        ApiResponse response = ApiResponse.fromJson(e.response?.data)
            .copyWith(message: "Retrying Request...");
        return response;
      }
      if (e.response!.statusCode! >= 500) {
        // Means it's server error, just log the user out...
        context!.read<AuthController>().logout;
        navigateAndClearAll(context, WelcomeBackScreen.routeName);
      }
      if (DioExceptionType.badResponse == e.type &&
          e.response?.data is Map<String, dynamic>) {
        ApiResponse response = ApiResponse.fromJson(e.response?.data);
        return response;
      }
    }
// If it gets to this part, means it did not hit the server at all...
    throw NetworkException(
      exceptionHandler(e.type, e.response?.statusCode, ctx: context),
    );
  }
}

String exceptionHandler(DioExceptionType? errorType, int? statusCode,
    {BuildContext? ctx}) {
  if (DioExceptionType.connectionTimeout == errorType ||
      DioExceptionType.connectionError == errorType) {
    return "Bad internet connection and please try again!";
  } else if (DioExceptionType.receiveTimeout == errorType &&
      DioExceptionType.sendTimeout == errorType) {
    return "Request has been timed out";
  } else {
    return "There seems to be a problem, Please try again later!";
  }
}
