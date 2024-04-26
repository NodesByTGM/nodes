

import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/subscription_model.dart';

part "subscription_history_model.g.dart";


@JsonSerializable(explicitToJson: true)
class SubscriptionHistoryModel extends BaseData {
final String? status;
    final DateTime? paidAt;
    final int? amount;
    final String? reference;
    final String? apiId;
    final String? description;
    final String? txnType;
    final String? source;
    final String? destination;
    final SubscriptionModel? subscription;
    final String? id;

   const SubscriptionHistoryModel({
        this.status,
        this.paidAt,
        this.amount,
        this.reference,
        this.apiId,
        this.description,
        this.txnType,
        this.source,
        this.destination,
        this.subscription,
        this.id,
    });

    SubscriptionHistoryModel copyWith({
        String? status,
        DateTime? paidAt,
        int? amount,
        String? reference,
        String? apiId,
        String? description,
        String? txnType,
        String? source,
        String? destination,
        SubscriptionModel? subscription,
        String? id,
    }) => 
        SubscriptionHistoryModel(
            status: status ?? this.status,
            paidAt: paidAt ?? this.paidAt,
            amount: amount ?? this.amount,
            reference: reference ?? this.reference,
            apiId: apiId ?? this.apiId,
            description: description ?? this.description,
            txnType: txnType ?? this.txnType,
            source: source ?? this.source,
            destination: destination ?? this.destination,
            subscription: subscription ?? this.subscription,
            id: id ?? this.id,
        );

  factory SubscriptionHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionHistoryModelToJson(this);



  @override
  List<SubscriptionHistoryModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => SubscriptionHistoryModel.fromJson(e)).toList();
    }
  }

   @override
  List<Object?> get props => [
      status,
paidAt,
amount,
reference,
apiId,
description,
txnType,
source,
destination,
subscription,
id,
  ];
}