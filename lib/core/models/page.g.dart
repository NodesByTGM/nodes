// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T extends BaseData>(Map<String, dynamic> json) =>
    Page<T>(
      currentPage: json['currentPage'] as int?,
      pageSize: json['pageSize'] as int?,
      totalPages: json['totalPages'] as int?,
      totalItems: json['totalItems'] as int?,
      items: json['items'] as List<dynamic>?,
    );

Map<String, dynamic> _$PageToJson<T extends BaseData>(Page<T> instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
