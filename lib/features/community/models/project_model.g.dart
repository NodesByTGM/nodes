// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
      projectId: json['projectId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      projectUrl: json['projectUrl'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      collaborators: (json['collaborators'] as List<dynamic>?)
          ?.map((e) => CollaboratorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'name': instance.name,
      'description': instance.description,
      'projectUrl': instance.projectUrl,
      'thumbnail': instance.thumbnail?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'collaborators': instance.collaborators?.map((e) => e.toJson()).toList(),
    };

CollaboratorModel _$CollaboratorModelFromJson(Map<String, dynamic> json) =>
    CollaboratorModel(
      name: json['name'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$CollaboratorModelToJson(CollaboratorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
    };

ThumbnailModel _$ThumbnailModelFromJson(Map<String, dynamic> json) =>
    ThumbnailModel(
      id: json['id'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ThumbnailModelToJson(ThumbnailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };
