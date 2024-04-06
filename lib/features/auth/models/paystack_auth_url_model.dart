// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/utilities/constants/key_strings.dart';

part "paystack_auth_url_model.g.dart";

@JsonSerializable(explicitToJson: true)
class CustomPaystackModel extends Equatable {
  final String? planKey;
  final String? reference;
  final String? callbackUrl;
  final PaystackMetadataModel? metadata;

  const CustomPaystackModel({
    this.planKey,
    this.reference,
    this.callbackUrl,
    this.metadata,
  });

  CustomPaystackModel copyWith({
    String? planKey,
    String? reference,
    String? callbackUrl,
    PaystackMetadataModel? metadata,
  }) =>
      CustomPaystackModel(
        planKey: planKey ?? this.planKey,
        reference: reference ?? this.reference,
        callbackUrl: callbackUrl ?? this.callbackUrl,
        metadata: metadata ?? this.metadata,
      );

  factory CustomPaystackModel.fromJson(Map<String, dynamic> json) =>
      _$CustomPaystackModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomPaystackModelToJson(this);

  @override
  List<Object?> get props => [
        planKey,
        reference,
        callbackUrl,
        metadata,
      ];
}

@JsonSerializable(explicitToJson: true)
class PaystackMetadataModel extends Equatable {
  final String? cancelAction;

  const PaystackMetadataModel({
    this.cancelAction,
  });

  PaystackMetadataModel copyWith({
    String? cancelAction,
  }) =>
      PaystackMetadataModel(
        cancelAction: cancelAction ?? this.cancelAction,
      );

  factory PaystackMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$PaystackMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaystackMetadataModelToJson(this);

  @override
  List<Object?> get props => [cancelAction];
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
