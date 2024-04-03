// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/features/auth/models/user_model.dart';

part 'current_session.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentSession extends Equatable {
  final String? refreshToken;
  final String? accessToken;
  final UserModel? user;
  final bool loggedIn;

  const CurrentSession({
    this.refreshToken,
    this.accessToken,
    this.user,
    this.loggedIn = false,
  });

  CurrentSession copyWith({
    String? refreshToken,
    String? accessToken,
    bool? loggedIn,
    UserModel? user,
  }) =>
      CurrentSession(
        refreshToken: refreshToken ?? this.refreshToken,
        accessToken: accessToken ?? this.accessToken, 
        user: user ?? this.user,
        loggedIn: loggedIn ?? this.loggedIn,
      );

  factory CurrentSession.fromJson(Map<String, dynamic> json) =>
      _$CurrentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentSessionToJson(this);

  @override
  List<dynamic> get props => [
        refreshToken,
        accessToken, 
        user,
        loggedIn,
      ];
}
