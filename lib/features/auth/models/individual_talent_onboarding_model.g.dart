// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_talent_onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualTalentOnboardingModel _$IndividualTalentOnboardingModelFromJson(
        Map<String, dynamic> json) =>
    IndividualTalentOnboardingModel(
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'] as String?,
      avatar: json['avatar'] == null
          ? null
          : MediaUploadModel.fromJson(json['avatar'] as Map<String, dynamic>),
      avatarFilePath: json['avatarFilePath'] as String?,
      linkedIn: json['linkedIn'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      otherPurpose: json['otherPurpose'] as String?,
      step: json['step'] as int?,
      onboardingPurpose: json['onboardingPurpose'] as int?,
      onboardingPurposes: (json['onboardingPurposes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$IndividualTalentOnboardingModelToJson(
        IndividualTalentOnboardingModel instance) =>
    <String, dynamic>{
      'skills': instance.skills,
      'location': instance.location,
      'avatar': instance.avatar?.toJson(),
      'avatarFilePath': instance.avatarFilePath,
      'linkedIn': instance.linkedIn,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'otherPurpose': instance.otherPurpose,
      'step': instance.step,
      'onboardingPurpose': instance.onboardingPurpose,
      'onboardingPurposes': instance.onboardingPurposes,
    };
