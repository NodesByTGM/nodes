// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_cms_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicCMSContentModel _$DynamicCMSContentModelFromJson(
        Map<String, dynamic> json) =>
    DynamicCMSContentModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : MediaUploadModel.fromJson(
              json['thumbnail'] as Map<String, dynamic>),
      category: json['category'] as String?,
      status: json['status'] as String?,
      author: json['author'] == null
          ? null
          : ApplicantModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      comments: json['comments'] as List<dynamic>?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DynamicCMSContentModelToJson(
        DynamicCMSContentModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail?.toJson(),
      'category': instance.category,
      'status': instance.status,
      'author': instance.author?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'comments': instance.comments,
      'id': instance.id,
    };
