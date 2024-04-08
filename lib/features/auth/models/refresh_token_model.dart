import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "refresh_token_model.g.dart";

@JsonSerializable(explicitToJson: true)
class RefreshTokenModel extends Equatable {
  final String? accessToken;
  final String? refreshToken;

  const RefreshTokenModel({
    this.accessToken,
    this.refreshToken,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenModelToJson(this);

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
