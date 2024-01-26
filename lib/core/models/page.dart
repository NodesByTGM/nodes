// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

part 'page.g.dart';

@JsonSerializable()
class Page<T extends BaseData> extends Equatable {
  final int? items_count;
  final int? total_pages;
  final int? current_page;
  final dynamic next;
  final dynamic previous;
  final dynamic next_url;
  final dynamic previous_url;
  final List? results;

  const Page({
    this.items_count,
    this.total_pages,
    this.current_page,
    this.next,
    this.previous,
    this.next_url,
    this.previous_url,
    this.results,
  });

  Page<T> fromJson(Map<String, dynamic> json, T t, [bool isMapped = false]) {
    // NB: Every Model, that extends this model MUST have a .fromList()
    final result =
        isObjectEmpty(json['results']) ? [] : t.fromList(json['results']);
    return Page<T>(
      items_count: json['items_count'],
      total_pages: json['total_pages'],
      current_page: json['current_page'],
      next: json['next'],
      previous: json['previous'],
      next_url: json['next_url'],
      previous_url: json['previous_url'],
      results: result,
    );
  }

  Page<T> copyWith({
    int? items_count,
    int? total_pages,
    int? current_page,
    dynamic next,
    dynamic previous,
    dynamic next_url,
    dynamic previous_url,
    List? results,
  }) {
    return Page<T>(
      items_count: items_count ?? this.items_count,
      total_pages: total_pages ?? this.total_pages,
      current_page: current_page ?? this.current_page,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      next_url: next_url ?? this.next_url,
      previous_url: previous_url ?? this.previous_url,
      results: results ?? this.results,
    );
  }

  Page<T> append({
    int? items_count,
    int? total_pages,
    int? current_page,
    dynamic next,
    dynamic previous,
    dynamic next_url,
    dynamic previous_url,
    List? results,
  }) {
    return Page<T>(
      items_count: items_count ?? this.items_count,
      total_pages: total_pages ?? this.total_pages,
      current_page: current_page ?? this.current_page,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      next_url: next_url ?? this.next_url,
      previous_url: previous_url ?? this.previous_url,
      results: (this.results ?? [])..addAll(results ?? []),
    );
  }

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  List<dynamic> get props => [
        items_count,
        total_pages,
        current_page,
        next,
        previous,
        next_url,
        previous_url,
        results,
      ];
}
