// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_show_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieShowModel _$MovieShowModelFromJson(Map<String, dynamic> json) =>
    MovieShowModel(
      backdropPath: json['backdropPath'] as String?,
      id: json['id'] as int?,
      originalName: json['originalName'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      mediaType: json['mediaType'] as String?,
      adult: json['adult'] as bool?,
      name: json['name'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
      genreIds:
          (json['genreIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      firstAirDate: json['firstAirDate'] == null
          ? null
          : DateTime.parse(json['firstAirDate'] as String),
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: json['voteCount'] as int?,
      originCountry: (json['originCountry'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MovieShowModelToJson(MovieShowModel instance) =>
    <String, dynamic>{
      'backdropPath': instance.backdropPath,
      'id': instance.id,
      'originalName': instance.originalName,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'mediaType': instance.mediaType,
      'adult': instance.adult,
      'name': instance.name,
      'originalLanguage': instance.originalLanguage,
      'genreIds': instance.genreIds,
      'popularity': instance.popularity,
      'firstAirDate': instance.firstAirDate?.toIso8601String(),
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'originCountry': instance.originCountry,
    };
