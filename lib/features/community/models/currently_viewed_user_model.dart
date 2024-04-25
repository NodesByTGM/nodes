import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "currently_viewed_user_model.g.dart";

@JsonSerializable(explicitToJson: true)
class CurrentlyViewedUser extends Equatable {
  final String? id;
  final int type;

  const CurrentlyViewedUser({
    this.id,
    this.type = 0,
  });

  factory CurrentlyViewedUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentlyViewedUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentlyViewedUserToJson(this);

  @override
  List<Object?> get props => [id, type];
}
