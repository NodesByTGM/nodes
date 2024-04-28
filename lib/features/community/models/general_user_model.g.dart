// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralUserModel _$GeneralUserModelFromJson(Map<String, dynamic> json) =>
    GeneralUserModel(
      name: json['name'] as String?,
      id: json['id'] as String?,
      avatar: json['avatar'] == null
          ? null
          : MediaUploadModel.fromJson(json['avatar'] as Map<String, dynamic>),
      type: json['type'] as int? ?? 0,
      headline: json['headline'] as String?,
      bio: json['bio'] as String?,
      connected: json['connected'] as bool? ?? false,
      requested: json['requested'] as bool? ?? false,
    );

Map<String, dynamic> _$GeneralUserModelToJson(GeneralUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'avatar': instance.avatar?.toJson(),
      'type': instance.type,
      'headline': instance.headline,
      'bio': instance.bio,
      'connected': instance.connected,
      'requested': instance.requested,
    };
