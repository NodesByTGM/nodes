import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';

part "trending_model.g.dart";

@JsonSerializable(explicitToJson: true)
class TrendingModelNews extends BaseData {
  final TrendingSourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const TrendingModelNews({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  TrendingModelNews copyWith({
    TrendingSourceModel? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      TrendingModelNews(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory TrendingModelNews.fromJson(Map<String, dynamic> json) =>
      _$TrendingModelNewsFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingModelNewsToJson(this);

  @override
  List<TrendingModelNews> fromList(List<dynamic> items) {
    if (items.isEmpty) {
      return [];
    } else {
      return items.map((e) => TrendingModelNews.fromJson(e)).toList();
    }
  }

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}

@JsonSerializable(explicitToJson: true)
class TrendingSourceModel extends Equatable {
  final String? id;
  final String? name;

  const TrendingSourceModel({
    this.id,
    this.name,
  });

  TrendingSourceModel copyWith({
    String? id,
    String? name,
  }) =>
      TrendingSourceModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory TrendingSourceModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingSourceModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
