// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessAccountModel _$BusinessAccountModelFromJson(
        Map<String, dynamic> json) =>
    BusinessAccountModel(
      verified: json['verified'] as bool? ?? false,
      cac: json['cac'],
      name: json['name'] as String?,
      yoe: json['yoe'] == null ? null : DateTime.parse(json['yoe'] as String),
      account: json['account'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BusinessAccountModelToJson(
        BusinessAccountModel instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'cac': instance.cac,
      'name': instance.name,
      'yoe': instance.yoe?.toIso8601String(),
      'account': instance.account,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
    };
