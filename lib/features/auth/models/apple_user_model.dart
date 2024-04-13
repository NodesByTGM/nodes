import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "apple_user_model.g.dart";

@JsonSerializable(explicitToJson: true)
class AppleUserModel extends Equatable {
  final String? email;
  final String? fullname;

  const AppleUserModel({
    this.email,
    this.fullname,
  });

  factory AppleUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppleUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppleUserModelToJson(this);

  @override
  List<Object?> get props => [email, fullname];
}
