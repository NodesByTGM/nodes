// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomPage<T> _$CustomPageFromJson<T extends BaseData>(
        Map<String, dynamic> json) =>
    CustomPage<T>(
      currentPage: json['currentPage'] as int?,
      pageSize: json['pageSize'] as int?,
      totalPages: json['totalPages'] as int?,
      totalItems: json['totalItems'] as int?,
      items: json['items'] as List<dynamic>?,
    );

Map<String, dynamic> _$CustomPageToJson<T extends BaseData>(
        CustomPage<T> instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
