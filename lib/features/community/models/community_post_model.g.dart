// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      body: json['body'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => MediaUploadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hashtags: (json['hashtags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String?,
      parent: json['parent'],
      likes: json['likes'] as List<dynamic>?,
      comments: json['comments'] as List<dynamic>?,
      author: json['author'] == null
          ? null
          : ApplicantModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      liked: json['liked'] as bool? ?? false,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'body': instance.body,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'hashtags': instance.hashtags,
      'type': instance.type,
      'parent': instance.parent,
      'likes': instance.likes,
      'comments': instance.comments,
      'author': instance.author?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'liked': instance.liked,
      'id': instance.id,
    };
