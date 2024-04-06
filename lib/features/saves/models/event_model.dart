import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';
import 'package:nodes/features/saves/models/job_model.dart';

part "event_model.g.dart";

@JsonSerializable(explicitToJson: true)
class EventModel extends BaseData {
  final String? name;
  final String? description;
  final String? location;
  final DateTime? dateTime;
  final String? paymentType;
  final MediaUploadModel? thumbnail;
  final List<ApplicantModel>? saves;
  final BusinessAccountModel? business;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool saved;
  final String? id;

  const EventModel({
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

  EventModel copyWith({
    String? name,
    String? description,
    String? location,
    DateTime? dateTime,
    String? paymentType,
    MediaUploadModel? thumbnail,
    List<ApplicantModel>? saves,
    BusinessAccountModel? business,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? saved,
    String? id,
  }) =>
      EventModel(
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

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  List<EventModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => EventModel.fromJson(e)).toList();
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
