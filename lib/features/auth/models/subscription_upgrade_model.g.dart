// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_upgrade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionUpgrade _$SubscriptionUpgradeFromJson(Map<String, dynamic> json) =>
    SubscriptionUpgrade(
      type: json['type'] as String?,
      description: json['description'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      period: json['period'] as String?,
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SubscriptionUpgradeToJson(
        SubscriptionUpgrade instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'amount': instance.amount,
      'period': instance.period,
      'features': instance.features,
    };
