// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      data: json['data'],
      status_code: json['status_code'] as int?,
      message: json['message'],
      status: json['status'] as String?,
      isError: json['isError'] as bool? ?? false,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.status_code,
      'data': instance.data,
      'message': instance.message,
      'isError': instance.isError,
    };
