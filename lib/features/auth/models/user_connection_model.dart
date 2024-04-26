import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/user_model.dart';

part "user_connection_model.g.dart";

@JsonSerializable(explicitToJson: true)
class UserConnectionModel extends BaseData {
  final UserModel? sender;
  final UserModel? recipient;
  final String? message;
  final String? id;
  final int? status;

  const UserConnectionModel({
    this.sender,
    this.recipient,
    this.message,
    this.id,
    this.status,
  });

  UserConnectionModel copyWith({
    UserModel? sender,
    UserModel? recipient,
    String? message,
    String? id,
    int? status,
  }) =>
      UserConnectionModel(
        sender: sender ?? this.sender,
        recipient: recipient ?? this.recipient,
        message: message ?? this.message,
        id: id ?? this.id,
        status: status ?? this.status,
      );

  factory UserConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$UserConnectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserConnectionModelToJson(this);

  @override
  List<UserConnectionModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => UserConnectionModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        sender,
        recipient,
        message,
        id,
        status,
      ];
}
