import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "individual_talent_onboarding_model.g.dart";

@JsonSerializable(explicitToJson: true)
class IndividualTalentOnboardingModel extends Equatable {
  final List<String>? skills;
  final String? location;
  final String? avatar;
  final String? avatarFilePath;
  final String? linkedIn;
  final String? instagram;
  final String? twitter;
  final String? otherPurpose;
  final int? step;
  final int? onboardingPurpose;

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
  });

  IndividualTalentOnboardingModel copyWith({
    List<String>? skills,
    String? location,
    String? avatar,
    String? avatarFilePath,
    String? linkedIn,
    String? instagram,
    String? twitter,
    String? otherPurpose,
    int? step,
    int? onboardingPurpose,
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
      ];
}
