import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "media_upload_model.g.dart";

@JsonSerializable(explicitToJson: true)
class MediaUploadModel extends Equatable {
  final String? dbId;
  final String id;
  final String url;

  const MediaUploadModel({
    this.dbId,
    required this.id,
    required this.url,
  });

  factory MediaUploadModel.fromJson(Map<String, dynamic> json) =>
      _$MediaUploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaUploadModelToJson(this);

  @override
  List<Object?> get props => [
        dbId,
        id,
        url,
      ];
}
