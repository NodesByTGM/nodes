// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/saves/models/event_model.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

part "event_model_standardTalent.g.dart";

@JsonSerializable(explicitToJson: true)
class StandardTalentEventModel extends BaseData {
  final String? name;
  final String? description;
  final String? location;
  final DateTime? dateTime;
  final String? paymentType;
  final MediaUploadModel? thumbnail;
  final int? saves;
  final BusinessAccountModel? business;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool saved;
  final String? id;

  const StandardTalentEventModel({
    this.name,
    this.description,
    this.location,
    this.dateTime,
    this.paymentType,
    this.thumbnail,
    this.saves,
    this.business,
    this.createdAt,
    this.updatedAt,
    this.saved = false,
    this.id,
  });

  StandardTalentEventModel copyWith({
    String? name,
    String? description,
    String? location,
    DateTime? dateTime,
    String? paymentType,
    MediaUploadModel? thumbnail,
    int? saves,
    BusinessAccountModel? business,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? saved,
    String? id,
  }) =>
      StandardTalentEventModel(
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        dateTime: dateTime ?? this.dateTime,
        paymentType: paymentType ?? this.paymentType,
        thumbnail: thumbnail ?? this.thumbnail,
        saves: saves ?? this.saves,
        business: business ?? this.business,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        saved: saved ?? this.saved,
        id: id ?? this.id,
      );

  factory StandardTalentEventModel.fromJson(Map<String, dynamic> json) =>
      _$StandardTalentEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$StandardTalentEventModelToJson(this);

  static StandardTalentEventModel toStandardTalentEvent(EventModel event) =>
      StandardTalentEventModel(
        name: event.name,
        description: event.description,
        location: event.location,
        dateTime: event.dateTime,
        paymentType: event.paymentType,
        thumbnail: event.thumbnail,
        saves: isObjectEmpty(event.saves) ? 0 : event.saves?.length,
        business: event.business,
        createdAt: event.createdAt,
        updatedAt: event.updatedAt,
        saved: event.saved,
        id: event.id,
      );

  @override
  List<StandardTalentEventModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => StandardTalentEventModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        name,
        description,
        location,
        dateTime,
        paymentType,
        thumbnail,
        saves,
        business,
        createdAt,
        updatedAt,
        false,
        id,
      ];
}
