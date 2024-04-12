import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "business_account_model.g.dart";

@JsonSerializable(explicitToJson: true)
class BusinessAccountModel extends Equatable {
  final bool verified;
  final dynamic cac;
  final String? name;
  final DateTime? yoe;
  final String? account;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  const BusinessAccountModel({
    this.verified = false,
    this.cac,
    this.name,
    this.yoe,
    this.account,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  BusinessAccountModel copyWith({
    bool? verified,
    dynamic cac,
    String? name,
    DateTime? yoe,
    String? account,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
  }) =>
      BusinessAccountModel(
        verified: verified ?? this.verified,
        cac: cac ?? this.cac,
        name: name ?? this.name,
        yoe: yoe ?? this.yoe,
        account: account ?? this.account,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
      );

  factory BusinessAccountModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessAccountModelToJson(this);

  @override
  List<Object?> get props => [
        verified,
        cac,
        name,
        yoe,
        account,
        createdAt,
        updatedAt,
        id,
      ];
}
