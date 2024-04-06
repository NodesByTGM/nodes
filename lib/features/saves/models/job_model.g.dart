// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      experience: json['experience'] as String?,
      payRate: json['payRate'] as String?,
      workRate: json['workRate'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      jobType: json['jobType'] as int?,
      applicants: (json['applicants'] as List<dynamic>?)
          ?.map((e) => ApplicantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      saves: (json['saves'] as List<dynamic>?)
          ?.map((e) => ApplicantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      applied: json['applied'] as bool? ?? false,
      saved: json['saved'] as bool? ?? false,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'experience': instance.experience,
      'payRate': instance.payRate,
      'workRate': instance.workRate,
      'skills': instance.skills,
      'jobType': instance.jobType,
      'applicants': instance.applicants?.map((e) => e.toJson()).toList(),
      'saves': instance.saves?.map((e) => e.toJson()).toList(),
      'business': instance.business?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'applied': instance.applied,
      'saved': instance.saved,
      'id': instance.id,
    };

ApplicantModel _$ApplicantModelFromJson(Map<String, dynamic> json) =>
    ApplicantModel(
      name: json['name'] as String?,
      avatar: json['avatar'],
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ApplicantModelToJson(ApplicantModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'id': instance.id,
    };
