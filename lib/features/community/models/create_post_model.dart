import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';

part "create_post_model.g.dart";

@JsonSerializable(explicitToJson: true)
class CreatePostModel extends Equatable {
  final String? body;
  final List<MediaUploadModel>? attachments;
  final List<String>? hashtags;

  const CreatePostModel({
    this.body,
    this.attachments,
    this.hashtags,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);

  @override
  List<Object?> get props => [
        body,
        attachments,
        hashtags,
      ];
}
