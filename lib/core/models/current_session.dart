// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_session.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentSession extends Equatable {
  final String? refresh;
  final String? access;
  final String? user_type;
  final String? uid;
  // final UserModel? user;

  const CurrentSession({
    this.refresh,
    this.access,
    this.user_type,
    this.uid,
    // this.user,
  });

  CurrentSession copyWith({
    String? refresh,
    String? access,
    String? user_type,
    String? uid,
    // UserModel? user,
  }) =>
      CurrentSession(
        refresh: refresh ?? this.refresh,
        access: access ?? this.access,
        user_type: user_type ?? this.user_type,
        uid: uid ?? this.uid,
        // user: user ?? this.user,
      );

  factory CurrentSession.fromJson(Map<String, dynamic> json) =>
      _$CurrentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentSessionToJson(this);

  @override
  List<dynamic> get props => [
        refresh,
        access,
        user_type,
        uid,
        // user,
      ];
}
