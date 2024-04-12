import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';

part "standard_talent_job_model.g.dart";

@JsonSerializable(explicitToJson: true)
class StandardTalentJobModel extends BaseData {
  final String? name;
  final String? description;
  final String? experience;
  final String? payRate;
  final String? workRate;
  final List<String>? skills;
  final int jobType;
  final int? applicants;
  final int? saves;
  final BusinessAccountModel? business;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool applied;
  final bool saved;
  final String? id;

  const StandardTalentJobModel({
    this.name,
    this.description,
    this.experience,
    this.payRate,
    this.workRate,
    this.skills,
    this.jobType = 0,
    this.applicants,
    this.saves,
    this.business,
    this.createdAt,
    this.updatedAt,
    this.applied = false,
    this.saved = false,
    this.id,
  });

  StandardTalentJobModel copyWith({
    String? name,
    String? description,
    String? experience,
    String? payRate,
    String? workRate,
    List<String>? skills,
    int? jobType,
    int? applicants,
    int? saves,
    BusinessAccountModel? business,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? applied,
    bool? saved,
    String? id,
  }) =>
      StandardTalentJobModel(
        name: name ?? this.name,
        description: description ?? this.description,
        experience: experience ?? this.experience,
        payRate: payRate ?? this.payRate,
        workRate: workRate ?? this.workRate,
        skills: skills ?? this.skills,
        jobType: jobType ?? this.jobType,
        applicants: applicants ?? this.applicants,
        saves: saves ?? this.saves,
        business: business ?? this.business,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        applied: applied ?? this.applied,
        saved: saved ?? this.saved,
        id: id ?? this.id,
      );

  factory StandardTalentJobModel.fromJson(Map<String, dynamic> json) =>
      _$StandardTalentJobModelFromJson(json);

  Map<String, dynamic> toJson() => _$StandardTalentJobModelToJson(this);

  @override
  List<StandardTalentJobModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => StandardTalentJobModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        name,
        description,
        experience,
        payRate,
        workRate,
        skills,
        jobType,
        business,
        createdAt,
        updatedAt,
        id,
        applied,
        saved,
      ];
}

@JsonSerializable(explicitToJson: true)
class BusinessJobModel extends BaseData {
  final String? name;
  final String? description;
  final String? experience;
  final String? payRate;
  final String? workRate;
  final List<String>? skills;
  final int? jobType;
  final List<ApplicantModel>? applicants;
  final List<ApplicantModel>? saves;
  final BusinessAccountModel? business;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool applied;
  final bool saved;
  final String? id;

  const BusinessJobModel({
    this.name,
    this.description,
    this.experience,
    this.payRate,
    this.workRate,
    this.skills,
    this.jobType,
    this.applicants,
    this.saves,
    this.business,
    this.createdAt,
    this.updatedAt,
    this.applied = false,
    this.saved = false,
    this.id,
  });

  BusinessJobModel copyWith({
    String? name,
    String? description,
    String? experience,
    String? payRate,
    String? workRate,
    List<String>? skills,
    int? jobType,
    List<ApplicantModel>? applicants,
    List<ApplicantModel>? saves,
    BusinessAccountModel? business,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? applied,
    bool? saved,
    String? id,
  }) =>
      BusinessJobModel(
        name: name ?? this.name,
        description: description ?? this.description,
        experience: experience ?? this.experience,
        payRate: payRate ?? this.payRate,
        workRate: workRate ?? this.workRate,
        skills: skills ?? this.skills,
        jobType: jobType ?? this.jobType,
        applicants: applicants ?? this.applicants,
        saves: saves ?? this.saves,
        business: business ?? this.business,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        applied: applied ?? this.applied,
        saved: saved ?? this.saved,
        id: id ?? this.id,
      );

  factory BusinessJobModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessJobModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessJobModelToJson(this);

  @override
  List<BusinessJobModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => BusinessJobModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        name,
        description,
        experience,
        payRate,
        workRate,
        skills,
        jobType,
        business,
        createdAt,
        updatedAt,
        id,
        applied,
        saved,
      ];
}

@JsonSerializable(explicitToJson: true)
class ApplicantModel extends Equatable {
  final String? name;
  final MediaUploadModel? avatar;
  final String? id;

  const ApplicantModel({
    this.name,
    this.avatar,
    this.id,
  });

  ApplicantModel copyWith({
    String? name,
    MediaUploadModel? avatar,
    String? id,
  }) =>
      ApplicantModel(
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        id: id ?? this.id,
      );

  factory ApplicantModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        avatar,
        id,
      ];
}
