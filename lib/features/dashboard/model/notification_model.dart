import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';

part "notification_model.g.dart";

@JsonSerializable(explicitToJson: true)
class NotificationModel extends BaseData {
  final String? id;
  final String? message;
  final String? foreignKey;
  final String? type;
  final DateTime? account;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NotificationModel({
    this.id,
    this.message,
    this.foreignKey,
    this.type,
    this.account,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel copyWith({
    String? id,
    String? message,
    String? foreignKey,
    String? type,
    DateTime? account,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        message: message ?? this.message,
        foreignKey: foreignKey ?? this.foreignKey,
        type: type ?? this.type,
        account: account ?? this.account,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<NotificationModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => NotificationModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        id,
        message,
        foreignKey,
        type,
        account,
        createdAt,
        updatedAt,
      ];
}
