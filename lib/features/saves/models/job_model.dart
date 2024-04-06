import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/business_account_model.dart';

part "job_model.g.dart";

@JsonSerializable(explicitToJson: true)
class JobModel extends BaseData {
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

   const JobModel({
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
        this.applied= false,
        this.saved = false,
        this.id,
    });

    JobModel copyWith({
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
        JobModel(
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

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);

  @override
  List<JobModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => JobModel.fromJson(e)).toList();
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
class ApplicantModel extends Equatable{
    final String? name;
    final dynamic avatar;
    final String? id;

  const  ApplicantModel({
        this.name,
        this.avatar,
        this.id,
    });

    ApplicantModel copyWith({
        String? name,
        dynamic avatar,
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
