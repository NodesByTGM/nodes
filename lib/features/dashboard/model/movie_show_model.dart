



import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';

part "movie_show_model.g.dart";


@JsonSerializable(explicitToJson: true)
class MovieShowModel extends BaseData {
final String? backdropPath;
    final int? id;
    final String? originalName;
    final String? overview;
    final String? posterPath;
    final String? mediaType;
    final bool? adult;
    final String? name;
    final String? originalLanguage;
    final List<int>? genreIds;
    final double? popularity;
    final DateTime? firstAirDate;
    final double? voteAverage;
    final int? voteCount;
    final List<String>? originCountry;

   const MovieShowModel({
        this.backdropPath,
        this.id,
        this.originalName,
        this.overview,
        this.posterPath,
        this.mediaType,
        this.adult,
        this.name,
        this.originalLanguage,
        this.genreIds,
        this.popularity,
        this.firstAirDate,
        this.voteAverage,
        this.voteCount,
        this.originCountry,
    });

    MovieShowModel copyWith({
        String? backdropPath,
        int? id,
        String? originalName,
        String? overview,
        String? posterPath,
        String? mediaType,
        bool? adult,
        String? name,
        String? originalLanguage,
        List<int>? genreIds,
        double? popularity,
        DateTime? firstAirDate,
        double? voteAverage,
        int? voteCount,
        List<String>? originCountry,
    }) => 
        MovieShowModel(
            backdropPath: backdropPath ?? this.backdropPath,
            id: id ?? this.id,
            originalName: originalName ?? this.originalName,
            overview: overview ?? this.overview,
            posterPath: posterPath ?? this.posterPath,
            mediaType: mediaType ?? this.mediaType,
            adult: adult ?? this.adult,
            name: name ?? this.name,
            originalLanguage: originalLanguage ?? this.originalLanguage,
            genreIds: genreIds ?? this.genreIds,
            popularity: popularity ?? this.popularity,
            firstAirDate: firstAirDate ?? this.firstAirDate,
            voteAverage: voteAverage ?? this.voteAverage,
            voteCount: voteCount ?? this.voteCount,
            originCountry: originCountry ?? this.originCountry,
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
      backdropPath,
id,
originalName,
overview,
posterPath,
mediaType,
adult,
name,
originalLanguage,
genreIds,
popularity,
firstAirDate,
voteAverage,
voteCount,
originCountry,
  ];
}