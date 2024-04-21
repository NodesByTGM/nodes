// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) =>
    CreatePostModel(
      body: json['body'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => MediaUploadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hashtags: (json['hashtags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) =>
    <String, dynamic>{
      'body': instance.body,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'hashtags': instance.hashtags,
    };
