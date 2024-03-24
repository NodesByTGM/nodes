// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryStateModel _$CountryStateModelFromJson(Map<String, dynamic> json) =>
    CountryStateModel(
      name: json['name'] as String?,
      states:
          (json['states'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CountryStateModelToJson(CountryStateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'states': instance.states,
    };
