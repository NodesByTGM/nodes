// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      type: json['type'] as int?,
      avatar: json['avatar'] as String?,
      verified: json['verified'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      accessToken: json['accessToken'] as String?,
      skills: json['skills'] as String?,
      location: json['location'] as String?,
      linkedIn: json['linkedIn'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      spaces: json['spaces'] as bool?,
      comments: json['comments'] as bool?,
      headline: json['headline'] as String?,
      bio: json['bio'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'dob': instance.dob?.toIso8601String(),
      'type': instance.type,
      'avatar': instance.avatar,
      'verified': instance.verified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'accessToken': instance.accessToken,
      'skills': instance.skills,
      'location': instance.location,
      'linkedIn': instance.linkedIn,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'spaces': instance.spaces,
      'comments': instance.comments,
      'headline': instance.headline,
      'bio': instance.bio,
      'website': instance.website,
    };
