import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';

part "dynamic_cms_content_model.g.dart";

@JsonSerializable(explicitToJson: true)
class DynamicCMSContentModel extends BaseData {
  final String? title;
  final String? description;
  final MediaUploadModel? thumbnail;
  final String? category;
  final String? status;
  final ApplicantModel? author;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? comments;
  final String? id;

  const DynamicCMSContentModel({
    this.title,
    this.description,
    this.thumbnail,
    this.category,
    this.status,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.comments,
    this.id,
  });

  DynamicCMSContentModel copyWith({
    String? title,
    String? description,
    MediaUploadModel? thumbnail,
    String? category,
    String? status,
    ApplicantModel? author,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? comments,
    String? id,
  }) =>
      DynamicCMSContentModel(
        title: title ?? this.title,
        description: description ?? this.description,
        thumbnail: thumbnail ?? this.thumbnail,
        category: category ?? this.category,
        status: status ?? this.status,
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        comments: comments ?? this.comments,
        id: id ?? this.id,
      );
  factory DynamicCMSContentModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicCMSContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicCMSContentModelToJson(this);

  @override
  List<DynamicCMSContentModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => DynamicCMSContentModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        title,
        description,
        thumbnail,
        category,
        status,
        author,
        createdAt,
        updatedAt,
        comments,
        id,
      ];
}
