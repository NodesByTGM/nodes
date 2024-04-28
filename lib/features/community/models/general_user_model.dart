import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/features/auth/models/media_upload_model.dart';

part "general_user_model.g.dart";

@JsonSerializable(explicitToJson: true)
class GeneralUserModel extends BaseData {
  final String? name;
  final String? id;
  final MediaUploadModel? avatar;
  final int type;
  final String? headline;
  final String? bio;
  final bool connected;
  final bool requested;

  const GeneralUserModel({
    this.name,
    this.id,
    this.avatar,
    this.type = 0,
    this.headline,
    this.bio,
    this.connected = false,
    this.requested = false,
  });

  GeneralUserModel copyWith({
    String? name,
    String? id,
    MediaUploadModel? avatar,
    int? type,
    String? headline,
    String? bio,
    bool? connected,
    bool? requested,
  }) =>
      GeneralUserModel(
        name: name ?? this.name,
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        type: type ?? this.type,
        headline: headline ?? this.headline,
        bio: bio ?? this.bio,
        connected: connected ?? this.connected,
        requested: requested ?? this.requested,
      );

  factory GeneralUserModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralUserModelToJson(this);

  @override
  List<GeneralUserModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => GeneralUserModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props =>
      [name, id, avatar, type, headline, bio, connected, requested];
}
