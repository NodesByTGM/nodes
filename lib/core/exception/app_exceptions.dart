import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nodes/utilities/utils/utils.dart';
import 'package:nodes/core/models/api_response.dart';

class NetworkException implements Exception {
  final dynamic msg;

  NetworkException([this.msg]);

  @override
  String toString() => "$msg";

  static ApiResponse errorHandler(DioException e, {BuildContext? context}) {
    if (!isObjectEmpty(e.response)) {
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
    return "Please check your internet connection and try again!";
  } else if (DioExceptionType.receiveTimeout == errorType &&
      DioExceptionType.sendTimeout == errorType) {
    return "Your request has been timed out";
  }  else {
    return "Something went wrong, Please try again later!";
  }
}
