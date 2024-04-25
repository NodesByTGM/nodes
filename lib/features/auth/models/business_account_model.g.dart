// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessAccountModel _$BusinessAccountModelFromJson(
        Map<String, dynamic> json) =>
    BusinessAccountModel(
      verified: json['verified'] as bool? ?? false,
      cac: json['cac'] == null
          ? null
          : MediaUploadModel.fromJson(json['cac'] as Map<String, dynamic>),
      yoe: json['yoe'] == null ? null : DateTime.parse(json['yoe'] as String),
      account: json['account'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      headline: json['headline'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      linkedIn: json['linkedIn'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      spaces: json['spaces'] as bool? ?? true,
      comments: json['comments'] as bool? ?? true,
      logo: json['logo'] == null
          ? null
          : MediaUploadModel.fromJson(json['logo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusinessAccountModelToJson(
        BusinessAccountModel instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'cac': instance.cac?.toJson(),
      'yoe': instance.yoe?.toIso8601String(),
      'account': instance.account,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'headline': instance.headline,
      'bio': instance.bio,
      'location': instance.location,
      'website': instance.website,
      'linkedIn': instance.linkedIn,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'spaces': instance.spaces,
      'comments': instance.comments,
      'logo': instance.logo?.toJson(),
    };
