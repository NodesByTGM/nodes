// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentSession _$CurrentSessionFromJson(Map<String, dynamic> json) =>
    CurrentSession(
      refresh: json['refresh'] as String?,
      access: json['access'] as String?,
      user_type: json['user_type'] as String?,
      uid: json['uid'] as String?,
      loggedIn: json['loggedIn'] as bool? ?? false,
    );

Map<String, dynamic> _$CurrentSessionToJson(CurrentSession instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
      'user_type': instance.user_type,
      'uid': instance.uid,
      'loggedIn': instance.loggedIn,
    };
