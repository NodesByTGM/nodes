import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/auth/models/subscription_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final DateTime? dob;
  final MediaUploadModel? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? verified;
  final int? type;
  final String? age;
  final String? bio;
  final bool? comments;
  final String? headline;
  final String? height;
  final String? instagram;
  final String? linkedIn;
  final String? location;
  final int? onboardingPurpose;
  final String? otherPurpose;
  final List<String>? skills;
  final bool? spaces;
  final int? step;
  final String? twitter;
  final String? website;
  final BusinessAccountModel? business;
  final SubscriptionModel? subscription;
  final bool visible;

  const UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.dob,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.verified,
    this.type,
    this.age,
    this.bio,
    this.comments,
    this.headline,
    this.height,
    this.instagram,
    this.linkedIn,
    this.location,
    this.onboardingPurpose,
    this.otherPurpose,
    this.skills,
    this.spaces,
    this.step,
    this.twitter,
    this.website,
    this.business,
    this.subscription,
    this.visible = true,
  });
  copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    DateTime? dob,
    MediaUploadModel? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? verified,
    int? type,
    String? age,
    String? bio,
    bool? comments,
    String? headline,
    String? height,
    String? instagram,
    String? linkedIn,
    String? location,
    int? onboardingPurpose,
    String? otherPurpose,
    List<String>? skills,
    bool? spaces,
    int? step,
    String? twitter,
    String? website,
    BusinessAccountModel? business,
    SubscriptionModel? subscription,
    bool? visible,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        dob: dob ?? this.dob,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        verified: verified ?? this.verified,
        type: type ?? this.type,
        age: age ?? this.age,
        bio: bio ?? this.bio,
        comments: comments ?? this.comments,
        headline: headline ?? this.headline,
        height: height ?? this.height,
        instagram: instagram ?? this.instagram,
        linkedIn: linkedIn ?? this.linkedIn,
        location: location ?? this.location,
        onboardingPurpose: onboardingPurpose ?? this.onboardingPurpose,
        otherPurpose: otherPurpose ?? this.otherPurpose,
        skills: skills ?? this.skills,
        spaces: spaces ?? this.spaces,
        step: step ?? this.step,
        twitter: twitter ?? this.twitter,
        website: website ?? this.website,
        business: business ?? this.business,
        subscription: subscription ?? this.subscription,
        visible: visible ?? this.visible,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        dob,
        avatar,
        createdAt,
        updatedAt,
        verified,
        type,
        age,
        bio,
        comments,
        headline,
        height,
        instagram,
        linkedIn,
        location,
        onboardingPurpose,
        otherPurpose,
        skills,
        spaces,
        step,
        twitter,
        website,
        business,
        subscription,
        visible,
      ];

  // List<UserModel> fromList(List items) {
  //   if(items.isNotEmpty) {
  //     return items.map((e) => UserModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
}
