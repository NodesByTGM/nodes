// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      apiObject: json['apiObject'] as String?,
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'],
      result: json['result'],
      isError: json['isError'] as bool? ?? false,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'apiObject': instance.apiObject,
      'code': instance.code,
      'status': instance.status,
      'isError': instance.isError,
      'message': instance.message,
      'result': instance.result,
    };
