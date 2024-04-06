// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paystack_auth_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomPaystackModel _$CustomPaystackModelFromJson(Map<String, dynamic> json) =>
    CustomPaystackModel(
      planKey: json['planKey'] as String?,
      reference: json['reference'] as String?,
      callbackUrl: json['callbackUrl'] as String?,
      metadata: json['metadata'] == null
          ? null
          : PaystackMetadataModel.fromJson(
              json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomPaystackModelToJson(
        CustomPaystackModel instance) =>
    <String, dynamic>{
      'planKey': instance.planKey,
      'reference': instance.reference,
      'callbackUrl': instance.callbackUrl,
      'metadata': instance.metadata?.toJson(),
    };

PaystackMetadataModel _$PaystackMetadataModelFromJson(
        Map<String, dynamic> json) =>
    PaystackMetadataModel(
      cancelAction: json['cancelAction'] as String?,
    );

Map<String, dynamic> _$PaystackMetadataModelToJson(
        PaystackMetadataModel instance) =>
    <String, dynamic>{
      'cancelAction': instance.cancelAction,
    };

CustomPaystackResModel _$CustomPaystackResModelFromJson(
        Map<String, dynamic> json) =>
    CustomPaystackResModel(
      authorization_url: json['authorization_url'] as String?,
      access_code: json['access_code'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$CustomPaystackResModelToJson(
        CustomPaystackResModel instance) =>
    <String, dynamic>{
      'authorization_url': instance.authorization_url,
      'access_code': instance.access_code,
      'reference': instance.reference,
    };
