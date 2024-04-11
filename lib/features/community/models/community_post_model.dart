import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/saves/models/standard_talent_job_model.dart';

part "community_post_model.g.dart";

@JsonSerializable(explicitToJson: true)
class PostModel extends BaseData {
  final String? body;
  final List<MediaUploadModel>? attachments;
  final List<String>? hashtags;
  final String? type;
  final dynamic parent;
  final List<dynamic>? likes;
  final List<dynamic>? comments;
  final ApplicantModel? author;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool liked;
  final String? id;

  const PostModel({
    this.body,
    this.attachments,
    this.hashtags,
    this.type,
    this.parent,
    this.likes,
    this.comments,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.liked = false,
    this.id,
  });

  PostModel copyWith({
    String? body,
    List<MediaUploadModel>? attachments,
    List<String>? hashtags,
    String? type,
    dynamic parent,
    List<dynamic>? likes,
    List<dynamic>? comments,
    ApplicantModel? author,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? liked,
    String? id,
  }) =>
      PostModel(
        body: body ?? this.body,
        attachments: attachments ?? this.attachments,
        hashtags: hashtags ?? this.hashtags,
        type: type ?? this.type,
        parent: parent ?? this.parent,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        liked: liked ?? this.liked,
        id: id ?? this.id,
      );
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  List<PostModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => PostModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        body,
        attachments,
        hashtags,
        type,
        parent,
        likes,
        comments,
        author,
        createdAt,
        updatedAt,
        liked,
        id,
      ];
}
