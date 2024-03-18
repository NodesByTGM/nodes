import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? username;
  final DateTime? dob;
  final int? type;
  final String? avatar;
  final bool? verified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? accessToken;
  final String? skills;
  final String? location;
  final String? linkedIn;
  final String? instagram;
  final String? twitter;
  final bool? spaces;
  final bool? comments;
  final String? headline;
  final String? bio;
  final String? website;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.dob,
    this.type,
    this.avatar,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.skills,
    this.location,
    this.linkedIn,
    this.instagram,
    this.twitter,
    this.spaces,
    this.comments,
    this.headline,
    this.bio,
    this.website,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? username,
    DateTime? dob,
    int? type,
    String? avatar,
    bool? verified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? accessToken,
    String? skills,
    String? location,
    String? linkedIn,
    String? instagram,
    String? twitter,
    bool? spaces,
    bool? comments,
    String? headline,
    String? bio,
    String? website,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        username: username ?? this.username,
        dob: dob ?? this.dob,
        type: type ?? this.type,
        avatar: avatar ?? this.avatar,
        verified: verified ?? this.verified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        accessToken: accessToken ?? this.accessToken,
        skills: skills ?? this.skills,
        location: location ?? this.location,
        linkedIn: linkedIn ?? this.linkedIn,
        instagram: instagram ?? this.instagram,
        twitter: twitter ?? this.twitter,
        spaces: spaces ?? this.spaces,
        comments: comments ?? this.comments,
        headline: headline ?? this.headline,
        bio: bio ?? this.bio,
        website: website ?? this.website,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        dob,
        type,
        avatar,
        verified,
        createdAt,
        updatedAt,
        accessToken,
        skills,
        location,
        linkedIn,
        instagram,
        twitter,
        spaces,
        comments,
        headline,
        bio,
        website,
      ];

  // List<UserModel> fromList(List items) {
  //   if(items.isNotEmpty) {
  //     return items.map((e) => UserModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
}
