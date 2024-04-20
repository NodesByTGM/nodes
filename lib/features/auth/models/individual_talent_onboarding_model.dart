
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';

part "individual_talent_onboarding_model.g.dart";

@JsonSerializable(explicitToJson: true)
class IndividualTalentOnboardingModel extends Equatable {
  final List<String>? skills;
  final String? location;
  final MediaUploadModel? avatar;
  final String? avatarFilePath;
  final String? linkedIn;
  final String? instagram;
  final String? twitter;
  final String? otherPurpose;
  final int? step;
  final int? onboardingPurpose;
  final List<String>? onboardingPurposes;

 const IndividualTalentOnboardingModel({
    this.skills,
    this.location,
    this.avatar,
    this.avatarFilePath,
    this.linkedIn,
    this.instagram,
    this.twitter,
    this.otherPurpose,
    this.step,
    this.onboardingPurpose,
    this.onboardingPurposes,
  });

  IndividualTalentOnboardingModel copyWith({
    List<String>? skills,
    String? location,
    MediaUploadModel? avatar,
    String? avatarFilePath,
    String? linkedIn,
    String? instagram,
    String? twitter,
    String? otherPurpose,
    int? step,
    int? onboardingPurpose,
    List<String>? onboardingPurposes,
  }) =>
      IndividualTalentOnboardingModel(
        skills: skills ?? this.skills,
        location: location ?? this.location,
        avatar: avatar ?? this.avatar,
        avatarFilePath: avatarFilePath ?? this.avatarFilePath,
        linkedIn: linkedIn ?? this.linkedIn,
        instagram: instagram ?? this.instagram,
        twitter: twitter ?? this.twitter,
        otherPurpose: otherPurpose ?? this.otherPurpose,
        step: step ?? this.step,
        onboardingPurpose: onboardingPurpose ?? this.onboardingPurpose,
        onboardingPurposes: onboardingPurposes ?? this.onboardingPurposes,
      );

  factory IndividualTalentOnboardingModel.fromJson(Map<String, dynamic> json) =>
      _$IndividualTalentOnboardingModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$IndividualTalentOnboardingModelToJson(this);

  @override
  List<Object?> get props => [
        skills,
        location,
        avatar,
        avatarFilePath,
        linkedIn,
        instagram,
        twitter,
        otherPurpose,
        step,
        onboardingPurpose,
        onboardingPurposes,
      ];
}
