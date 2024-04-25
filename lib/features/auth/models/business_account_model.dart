import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';

part "business_account_model.g.dart";

@JsonSerializable(explicitToJson: true)
class BusinessAccountModel extends Equatable {
  final bool verified;
  final MediaUploadModel? cac;
  final DateTime? yoe;
  final String? account;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? name;
  final String? username;
  final String? headline;
  final String? bio;
  final String? location;
  final String? website;
  final String? linkedIn;
  final String? instagram;
  final String? twitter;
  final bool spaces;
  final bool comments;
  final MediaUploadModel? logo;

  const BusinessAccountModel({
    this.verified = false,
    this.cac,
    this.yoe,
    this.account,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.name,
    this.username,
    this.headline,
    this.bio,
    this.location,
    this.website,
    this.linkedIn,
    this.instagram,
    this.twitter,
    this.spaces = true,
    this.comments = true,
    this.logo,
  });

  BusinessAccountModel copyWith({
    bool? verified,
    MediaUploadModel? cac,
    DateTime? yoe,
    String? account,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    String? username,
    String? headline,
    String? bio,
    String? location,
    String? website,
    String? linkedIn,
    String? instagram,
    String? twitter,
    bool? spaces,
    bool? comments,
    MediaUploadModel? logo,
  }) =>
      BusinessAccountModel(
        verified: verified ?? this.verified,
        cac: cac ?? this.cac,
        yoe: yoe ?? this.yoe,
        account: account ?? this.account,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        headline: headline ?? this.headline,
        bio: bio ?? this.bio,
        location: location ?? this.location,
        website: website ?? this.website,
        linkedIn: linkedIn ?? this.linkedIn,
        instagram: instagram ?? this.instagram,
        twitter: twitter ?? this.twitter,
        spaces: spaces ?? this.spaces,
        comments: comments ?? this.comments,
        logo: logo ?? this.logo,
      );

  factory BusinessAccountModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessAccountModelToJson(this);

  @override
  List<Object?> get props => [
        verified,
        cac,
        yoe,
        account,
        createdAt,
        updatedAt,
        id,
        name,
        username,
        headline,
        bio,
        location,
        website,
        linkedIn,
        instagram,
        twitter,
        spaces,
        comments,
        logo,
      ];
}
