// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      dob: json['dob'] as String?,
      otp: json['otp'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'dob': instance.dob,
      'otp': instance.otp,
      'password': instance.password,
    };
