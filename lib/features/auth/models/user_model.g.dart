// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      avatar: json['avatar'] == null
          ? null
          : MediaUploadModel.fromJson(json['avatar'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      verified: json['verified'] as bool?,
      type: json['type'] as int? ?? 0,
      age: json['age'] as String?,
      bio: json['bio'] as String?,
      comments: json['comments'] as bool?,
      headline: json['headline'] as String?,
      height: json['height'] as String?,
      instagram: json['instagram'] as String?,
      linkedIn: json['linkedIn'] as String?,
      location: json['location'] as String?,
      onboardingPurpose: json['onboardingPurpose'] as int?,
      otherPurpose: json['otherPurpose'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      spaces: json['spaces'] as bool?,
      step: json['step'] as int? ?? 0,
      twitter: json['twitter'] as String?,
      website: json['website'] as String?,
      business: json['business'] == null
          ? null
          : BusinessAccountModel.fromJson(
              json['business'] as Map<String, dynamic>),
      subscription: json['subscription'] == null
          ? null
          : SubscriptionModel.fromJson(
              json['subscription'] as Map<String, dynamic>),
      visible: json['visible'] as bool? ?? true,
      firebaseToken: json['firebaseToken'] as String?,
      connections: (json['connections'] as List<dynamic>?)
          ?.map((e) => UserConnectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      requested: json['requested'] as bool? ?? false,
      connected: json['connected'] as bool? ?? false,
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => BusinessJobModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'dob': instance.dob?.toIso8601String(),
      'avatar': instance.avatar?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'verified': instance.verified,
      'type': instance.type,
      'age': instance.age,
      'bio': instance.bio,
      'comments': instance.comments,
      'headline': instance.headline,
      'height': instance.height,
      'instagram': instance.instagram,
      'linkedIn': instance.linkedIn,
      'location': instance.location,
      'onboardingPurpose': instance.onboardingPurpose,
      'otherPurpose': instance.otherPurpose,
      'skills': instance.skills,
      'spaces': instance.spaces,
      'step': instance.step,
      'twitter': instance.twitter,
      'website': instance.website,
      'business': instance.business?.toJson(),
      'subscription': instance.subscription?.toJson(),
      'visible': instance.visible,
      'firebaseToken': instance.firebaseToken,
      'connections': instance.connections?.map((e) => e.toJson()).toList(),
      'requested': instance.requested,
      'connected': instance.connected,
      'projects': instance.projects?.map((e) => e.toJson()).toList(),
      'events': instance.events?.map((e) => e.toJson()).toList(),
      'jobs': instance.jobs?.map((e) => e.toJson()).toList(),
    };
