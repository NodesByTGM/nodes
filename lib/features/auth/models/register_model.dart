import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "register_model.g.dart";

@JsonSerializable(explicitToJson: true)
class RegisterModel extends Equatable {
  final String? name;
  final String? username;
  final String? email;
  final String? dob;
  final String? otp;
  final String? password;

  const RegisterModel({
    this.name,
    this.username,
    this.email,
    this.dob,
    this.otp,
    this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        username,
        email,
        dob,
        otp,
        password,
      ];
}
