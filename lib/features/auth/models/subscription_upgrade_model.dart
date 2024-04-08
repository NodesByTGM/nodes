import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "subscription_upgrade_model.g.dart";

@JsonSerializable(explicitToJson: true)
class SubscriptionUpgrade extends Equatable {
  final String? type;
  final String? description;
  final double? amount;
  final String? period;
  final List<String>? features;

  const SubscriptionUpgrade({
    this.type,
    this.description,
    this.amount,
    this.period,
    this.features,
  });

  factory SubscriptionUpgrade.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionUpgradeFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionUpgradeToJson(this);

  @override
  List<Object?> get props => [
        type,
        description,
        amount,
        period,
        features,
      ];
}
