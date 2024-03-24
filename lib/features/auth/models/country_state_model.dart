import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_state_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryStateModel extends Equatable {
  final String? name;
  final List<String>? states;

  const CountryStateModel({
    this.name,
    this.states,
  });

  factory CountryStateModel.fromJson(Map<String, dynamic> json) =>
      _$CountryStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryStateModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        states,
      ];

  List<CountryStateModel> fromList(List items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => CountryStateModel.fromJson(e)).toList();
    }
  }
}
