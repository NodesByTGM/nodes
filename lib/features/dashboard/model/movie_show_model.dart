// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';

part "movie_show_model.g.dart";

@JsonSerializable(explicitToJson: true)
class MovieShowModel extends BaseData {
  final String? backdrop_path;
  final int? id;
  final String? original_name;
  final String? original_title;
  final String? overview;
  final String? poster_path;
  final String? media_type;
  final bool? adult;
  final String? name;
  final String? original_language;
  final List<int>? genre_ids;
  final double? popularity;
  final DateTime? first_air_date;
  final double? vote_average;
  final int? vote_count;
  final List<String>? origin_country;

  const MovieShowModel({
    this.backdrop_path,
    this.id,
    this.original_name,
    this.original_title,
    this.overview,
    this.poster_path,
    this.media_type,
    this.adult,
    this.name,
    this.original_language,
    this.genre_ids,
    this.popularity,
    this.first_air_date,
    this.vote_average,
    this.vote_count,
    this.origin_country,
  });

  MovieShowModel copyWith({
    String? backdrop_path,
    int? id,
    String? original_name,
    String? original_title,
    String? overview,
    String? poster_path,
    String? media_type,
    bool? adult,
    String? name,
    String? original_language,
    List<int>? genre_ids,
    double? popularity,
    DateTime? first_air_date,
    double? vote_average,
    int? vote_count,
    List<String>? origin_country,
  }) =>
      MovieShowModel(
        backdrop_path: backdrop_path ?? this.backdrop_path,
        id: id ?? this.id,
        original_name: original_name ?? this.original_name,
        original_title: original_title ?? this.original_title,
        overview: overview ?? this.overview,
        poster_path: poster_path ?? this.poster_path,
        media_type: media_type ?? this.media_type,
        adult: adult ?? this.adult,
        name: name ?? this.name,
        original_language: original_language ?? this.original_language,
        genre_ids: genre_ids ?? this.genre_ids,
        popularity: popularity ?? this.popularity,
        first_air_date: first_air_date ?? this.first_air_date,
        vote_average: vote_average ?? this.vote_average,
        vote_count: vote_count ?? this.vote_count,
        origin_country: origin_country ?? this.origin_country,
      );

  factory MovieShowModel.fromJson(Map<String, dynamic> json) =>
      _$MovieShowModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieShowModelToJson(this);

  @override
  List<MovieShowModel> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => MovieShowModel.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        backdrop_path,
        id,
        original_name,
        original_title,
        overview,
        poster_path,
        media_type,
        adult,
        name,
        original_language,
        genre_ids,
        popularity,
        first_air_date,
        vote_average,
        vote_count,
        origin_country,
      ];
}
