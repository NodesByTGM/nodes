// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T extends BaseData>(Map<String, dynamic> json) =>
    Page<T>(
      items_count: json['items_count'] as int?,
      total_pages: json['total_pages'] as int?,
      current_page: json['current_page'] as int?,
      next: json['next'],
      previous: json['previous'],
      next_url: json['next_url'],
      previous_url: json['previous_url'],
      results: json['results'] as List<dynamic>?,
    );

Map<String, dynamic> _$PageToJson<T extends BaseData>(Page<T> instance) =>
    <String, dynamic>{
      'items_count': instance.items_count,
      'total_pages': instance.total_pages,
      'current_page': instance.current_page,
      'next': instance.next,
      'previous': instance.previous,
      'next_url': instance.next_url,
      'previous_url': instance.previous_url,
      'results': instance.results,
    };
