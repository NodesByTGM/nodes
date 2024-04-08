// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

part 'custom_page.g.dart';

@JsonSerializable()
class CustomPage<T extends BaseData> extends Equatable {
  final int? currentPage;
  final int? pageSize;
  final int? totalPages;
  final int? totalItems;
  final List? items;

  const CustomPage({
    this.currentPage,
    this.pageSize,
    this.totalPages,
    this.totalItems,
    this.items,
  });

  CustomPage<T> fromJson(Map<String, dynamic> json, T t,
      [bool isMapped = false]) {
    // NB: Every Model, that extends this model MUST have a .fromList()
    final result =
        isObjectEmpty(json['items']) ? [] : t.fromList(json['items']);
    return CustomPage<T>(
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      items: result,
    );
  }

  CustomPage<T> copyWith({
    int? currentPage,
    int? pageSize,
    int? totalPages,
    int? totalItems,
    List? items,
  }) {
    return CustomPage<T>(
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      items: items ?? this.items,
    );
  }

  CustomPage<T> append({
    int? currentPage,
    int? pageSize,
    int? totalPages,
    int? totalItems,
    List? items,
  }) {
    return CustomPage<T>(
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      items: (this.items ?? [])..addAll(items ?? []),
    );
  }

  factory CustomPage.fromJson(Map<String, dynamic> json) => _$CustomPageFromJson(json);

  Map<String, dynamic> toJson() => _$CustomPageToJson(this);

  // List<CustomPage<T>> fromList(List items) {
  //   if (items.isEmpty) {
  //     return [];
  //   } else {
  //     return items.map((e) => CustomPage<T>.fromJson(e)).toList();
  //   }
  // }

  @override
  List<dynamic> get props => [
        currentPage,
        pageSize,
        totalPages,
        totalItems,
        items,
      ];
}
