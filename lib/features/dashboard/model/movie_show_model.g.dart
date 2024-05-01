// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_show_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieShowModel _$MovieShowModelFromJson(Map<String, dynamic> json) =>
    MovieShowModel(
      backdrop_path: json['backdrop_path'] as String?,
      id: json['id'] as int?,
      original_name: json['original_name'] as String?,
      original_title: json['original_title'] as String?,
      overview: json['overview'] as String?,
      poster_path: json['poster_path'] as String?,
      media_type: json['media_type'] as String?,
      adult: json['adult'] as bool?,
      name: json['name'] as String?,
      original_language: json['original_language'] as String?,
      genre_ids:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      first_air_date: json['first_air_date'] == null
          ? null
          : DateTime.parse(json['first_air_date'] as String),
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      vote_count: json['vote_count'] as int?,
      origin_country: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MovieShowModelToJson(MovieShowModel instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdrop_path,
      'id': instance.id,
      'original_name': instance.original_name,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'media_type': instance.media_type,
      'adult': instance.adult,
      'name': instance.name,
      'original_language': instance.original_language,
      'genre_ids': instance.genre_ids,
      'popularity': instance.popularity,
      'first_air_date': instance.first_air_date?.toIso8601String(),
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'origin_country': instance.origin_country,
    };
