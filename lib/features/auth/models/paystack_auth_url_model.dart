// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "paystack_auth_url_model.g.dart";

@JsonSerializable(explicitToJson: true)
class CustomPaystackModel extends Equatable {
  final String? planKey;
  final String? reference;
  final String? callback_url;
  final PaystackMetadataModel? metadata;

  const CustomPaystackModel({
    this.planKey,
    this.reference,
    this.callback_url,
    this.metadata,
  });

  CustomPaystackModel copyWith({
    String? planKey,
    String? reference,
    String? callback_url,
    PaystackMetadataModel? metadata,
  }) =>
      CustomPaystackModel(
        planKey: planKey ?? this.planKey,
        reference: reference ?? this.reference,
        callback_url: callback_url ?? this.callback_url,
        metadata: metadata ?? this.metadata,
      );

  factory CustomPaystackModel.fromJson(Map<String, dynamic> json) =>
      _$CustomPaystackModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomPaystackModelToJson(this);

  @override
  List<Object?> get props => [
        planKey,
        reference,
        callback_url,
        metadata,
      ];
}

@JsonSerializable(explicitToJson: true)
class PaystackMetadataModel extends Equatable {
  final String? cancel_action;

  const PaystackMetadataModel({
    this.cancel_action,
  });

  PaystackMetadataModel copyWith({
    String? cancel_action,
  }) =>
      PaystackMetadataModel(
        cancel_action: cancel_action ?? this.cancel_action,
      );

  factory PaystackMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$PaystackMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaystackMetadataModelToJson(this);

  @override
  List<Object?> get props => [cancel_action];
}

@JsonSerializable(explicitToJson: true)
class CustomPaystackResModel extends Equatable {
  final String? authorization_url;
  final String? access_code;
  final String? reference;

  const CustomPaystackResModel({
    this.authorization_url,
    this.access_code,
    this.reference,
  });

  factory CustomPaystackResModel.fromJson(Map<String, dynamic> json) =>
      _$CustomPaystackResModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomPaystackResModelToJson(this);

  @override
  List<Object?> get props => [
        authorization_url,
        access_code,
        reference,
      ];
}
