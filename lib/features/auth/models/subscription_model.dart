import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "subscription_model.g.dart";


@JsonSerializable(explicitToJson: true)
class SubscriptionModel extends Equatable {
final String? plan;
    final bool? active;
    final DateTime? paidAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? id;

const SubscriptionModel({
        this.plan,
        this.active,
        this.paidAt,
        this.createdAt,
        this.updatedAt,
        this.id,
    });

    SubscriptionModel copyWith({
        String? plan,
        bool? active,
        DateTime? paidAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? id,
    }) => 
        SubscriptionModel(
            plan: plan ?? this.plan,
            active: active ?? this.active,
            paidAt: paidAt ?? this.paidAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            id: id ?? this.id,
        );



  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);


   @override
  List<Object?> get props => [
      plan,
active,
paidAt,
createdAt,
updatedAt,
id,
  ];
}