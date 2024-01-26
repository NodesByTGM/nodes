// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResponse extends Equatable {
  final String? status;
  final int? status_code;
  final Object? data;
  // final Map<String, dynamic>? message;
  final dynamic message;
  final bool isError;

  /// message , status_code and status

  const ApiResponse({
    this.data,
    this.status_code,
    this.message,
    this.status,
    this.isError = false,
  });

  ApiResponse copyWith({
    String? status,
    int? status_code,
    Object? data,
    // Map<String, dynamic>? message,
    dynamic message,
    bool? isError,
  }) {
    return ApiResponse(
      status: status ?? this.status,
      status_code: status_code ?? this.status_code,
      data: data ?? this.data,
      message: message ?? this.message,
      isError: isError ?? this.isError,
    );
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<dynamic> get props => [
        status,
        status_code,
        data,
        message,
        isError,
      ];
}

