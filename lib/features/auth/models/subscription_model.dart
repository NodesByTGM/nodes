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
    final String? tenor;

const SubscriptionModel({
        this.plan,
        this.active,
        this.paidAt,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.tenor,
    });

    SubscriptionModel copyWith({
        String? plan,
        bool? active,
        DateTime? paidAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? id,
        String? tenor,
    }) => 
        SubscriptionModel(
            plan: plan ?? this.plan,
            active: active ?? this.active,
            paidAt: paidAt ?? this.paidAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            id: id ?? this.id,
            tenor: tenor ?? this.tenor,
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
tenor,
  ];
}