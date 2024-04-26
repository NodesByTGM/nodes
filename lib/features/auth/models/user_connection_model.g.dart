// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConnectionModel _$UserConnectionModelFromJson(Map<String, dynamic> json) =>
    UserConnectionModel(
      sender: json['sender'] == null
          ? null
          : UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      recipient: json['recipient'] == null
          ? null
          : UserModel.fromJson(json['recipient'] as Map<String, dynamic>),
      message: json['message'] as String?,
      id: json['id'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$UserConnectionModelToJson(
        UserConnectionModel instance) =>
    <String, dynamic>{
      'sender': instance.sender?.toJson(),
      'recipient': instance.recipient?.toJson(),
      'message': instance.message,
      'id': instance.id,
      'status': instance.status,
    };
