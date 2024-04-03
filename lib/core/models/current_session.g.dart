// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentSession _$CurrentSessionFromJson(Map<String, dynamic> json) =>
    CurrentSession(
      refreshToken: json['refreshToken'] as String?,
      accessToken: json['accessToken'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      loggedIn: json['loggedIn'] as bool? ?? false,
    );

Map<String, dynamic> _$CurrentSessionToJson(CurrentSession instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
      'user': instance.user?.toJson(),
      'loggedIn': instance.loggedIn,
    };
