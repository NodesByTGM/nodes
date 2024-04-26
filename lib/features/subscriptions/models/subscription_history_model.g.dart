// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionHistoryModel _$SubscriptionHistoryModelFromJson(
        Map<String, dynamic> json) =>
    SubscriptionHistoryModel(
      status: json['status'] as String?,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      amount: json['amount'] as int?,
      reference: json['reference'] as String?,
      apiId: json['apiId'] as String?,
      description: json['description'] as String?,
      txnType: json['txnType'] as String?,
      source: json['source'] as String?,
      destination: json['destination'] as String?,
      subscription: json['subscription'] == null
          ? null
          : SubscriptionModel.fromJson(
              json['subscription'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SubscriptionHistoryModelToJson(
        SubscriptionHistoryModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'paidAt': instance.paidAt?.toIso8601String(),
      'amount': instance.amount,
      'reference': instance.reference,
      'apiId': instance.apiId,
      'description': instance.description,
      'txnType': instance.txnType,
      'source': instance.source,
      'destination': instance.destination,
      'subscription': instance.subscription?.toJson(),
      'id': instance.id,
    };
