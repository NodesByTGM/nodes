import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "project_model.g.dart";

@JsonSerializable(explicitToJson: true)
class ProjectModel extends Equatable {
  final String? projectId;
  final String? name;
  final String? description;
  final String? projectUrl;
  final ThumbnailModel? thumbnail;
  final List<ThumbnailModel>? images;
  final List<CollaboratorModel>? collaborators;

  const ProjectModel({
    this.projectId,
    this.name,
    this.description,
    this.projectUrl,
    this.thumbnail,
    this.images,
    this.collaborators,
  });
  ProjectModel copyWith({
    String? projectId,
    String? name,
    String? description,
    String? projectUrl,
    ThumbnailModel? thumbnail,
    List<ThumbnailModel>? images,
    List<CollaboratorModel>? collaborators,
  }) =>
      ProjectModel(
        projectId: projectId ?? this.projectId,
        name: name ?? this.name,
        description: description ?? this.description,
        projectUrl: projectUrl ?? this.projectUrl,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        collaborators: collaborators ?? this.collaborators,
      );

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

  @override
  List<Object?> get props => [
        projectId,
        name,
        description,
        projectUrl,
        thumbnail,
        images,
        collaborators,
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

@JsonSerializable(explicitToJson: true)
class ThumbnailModel extends Equatable {
  final String? id;
  final String? url;

  const ThumbnailModel({
    this.id,
    this.url,
  });

  ThumbnailModel copyWith({
    String? id,
    String? url,
  }) =>
      ThumbnailModel(
        id: id ?? this.id,
        url: url ?? this.url,
      );

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailModelToJson(this);

  @override
  List<Object?> get props => [id, url];
}
