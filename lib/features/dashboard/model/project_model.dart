import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';

part "project_model.g.dart";

@JsonSerializable(explicitToJson: true)
class ProjectModel extends BaseData {
  final String? name;
  final String? description;
  final String? projectURL;
  final MediaUploadModel? thumbnail;
  final List<MediaUploadModel>? images;
  final List<CollaboratorModel>? collaborators;
  final String? account;
  final String? owner;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  const ProjectModel({
    this.name,
    this.description,
    this.projectURL,
    this.thumbnail,
    this.images,
    this.collaborators,
    this.account,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  ProjectModel copyWith({
    String? name,
    String? description,
    String? projectURL,
    MediaUploadModel? thumbnail,
    List<MediaUploadModel>? images,
    List<CollaboratorModel>? collaborators,
    String? account,
    String? owner,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
  }) =>
      ProjectModel(
        name: name ?? this.name,
        description: description ?? this.description,
        projectURL: projectURL ?? this.projectURL,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        collaborators: collaborators ?? this.collaborators,
        account: account ?? this.account,
        owner: owner ?? this.owner,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
      );

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

  @override
  List<ProjectModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => ProjectModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        name,
        description,
        projectURL,
        thumbnail,
        images,
        collaborators,
        account,
        owner,
        createdAt,
        updatedAt,
        id,
      ];
}

@JsonSerializable(explicitToJson: true)
class CollaboratorModel extends Equatable {
  final String? name;
  final String? role;

  const CollaboratorModel({
    this.name,
    this.role,
  });

  CollaboratorModel copyWith({
    String? name,
    String? role,
  }) =>
      CollaboratorModel(
        name: name ?? this.name,
        role: role ?? this.role,
      );

  factory CollaboratorModel.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollaboratorModelToJson(this);

  @override
  List<Object?> get props => [name, role];
}
