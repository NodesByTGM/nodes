// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      projectURL: json['projectURL'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : MediaUploadModel.fromJson(
              json['thumbnail'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => MediaUploadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      collaborators: (json['collaborators'] as List<dynamic>?)
          ?.map((e) => CollaboratorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      account: json['account'] as String?,
      owner: json['owner'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'projectURL': instance.projectURL,
      'thumbnail': instance.thumbnail?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'collaborators': instance.collaborators?.map((e) => e.toJson()).toList(),
      'account': instance.account,
      'owner': instance.owner,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
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
