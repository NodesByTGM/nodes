// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConnectionModel _$UserConnectionModelFromJson(Map<String, dynamic> json) =>
    UserConnectionModel(
      sender: json['sender'] as String?,
      recipient: json['recipient'] as String?,
      message: json['message'] as String?,
      id: json['id'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$UserConnectionModelToJson(
        UserConnectionModel instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'recipient': instance.recipient,
      'message': instance.message,
      'id': instance.id,
      'status': instance.status,
    };
