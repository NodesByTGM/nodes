// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingNewsModel _$TrendingNewsModelFromJson(Map<String, dynamic> json) =>
    TrendingNewsModel(
      source: json['source'] == null
          ? null
          : TrendingSourceModel.fromJson(
              json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$TrendingNewsModelToJson(TrendingNewsModel instance) =>
    <String, dynamic>{
      'source': instance.source?.toJson(),
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'content': instance.content,
    };

TrendingSourceModel _$TrendingSourceModelFromJson(Map<String, dynamic> json) =>
    TrendingSourceModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TrendingSourceModelToJson(
        TrendingSourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
