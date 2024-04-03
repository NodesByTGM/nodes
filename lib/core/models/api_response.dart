// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResponse extends Equatable {
  final String? apiObject;
  final int? code;
  final String? status;
  final bool? isError;
  final dynamic message;
  final dynamic result;

  /// message , status_code and status

  const ApiResponse({
    this.apiObject,
    this.code,
    this.status,
    this.message,
    this.result,
    this.isError = false,
  });

  ApiResponse copyWith({
    String? apiObject,
    int? code,
    String? status,
    bool? isError,
    dynamic message,
    dynamic result,
  }) {
    return ApiResponse(
      apiObject: apiObject ?? this.apiObject,
      code: code ?? this.code,
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
      isError: isError ?? this.isError,
    );
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<dynamic> get props => [
        apiObject,
        code,
        status,
        message,
        result,
        isError,
      ];
}
