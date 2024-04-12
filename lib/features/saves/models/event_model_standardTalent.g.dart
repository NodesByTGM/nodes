// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model_standardTalent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardTalentEventModel _$StandardTalentEventModelFromJson(
        Map<String, dynamic> json) =>
    StandardTalentEventModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      paymentType: json['paymentType'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : MediaUploadModel.fromJson(
              json['thumbnail'] as Map<String, dynamic>),
      saves: json['saves'] as int?,
      business: json['business'] == null
          ? null
          : BusinessAccountModel.fromJson(
              json['business'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      saved: json['saved'] as bool? ?? false,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$StandardTalentEventModelToJson(
        StandardTalentEventModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'dateTime': instance.dateTime?.toIso8601String(),
      'paymentType': instance.paymentType,
      'thumbnail': instance.thumbnail?.toJson(),
      'saves': instance.saves,
      'business': instance.business?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'saved': instance.saved,
      'id': instance.id,
    };
