// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nodes/core/models/base_data.dart';
import 'package:nodes/utilities/constants/exported_packages.dart';

part 'page.g.dart';

@JsonSerializable()
class Page<T extends BaseData> extends Equatable {
  final int? currentPage;
  final int? pageSize;
  final int? totalPages;
  final int? totalItems;
  final List? items;

  const Page({
    this.currentPage,
    this.pageSize,
    this.totalPages,
    this.totalItems,
    this.items,
  });

  Page<T> fromJson(Map<String, dynamic> json, T t, [bool isMapped = false]) {
    // NB: Every Model, that extends this model MUST have a .fromList()
    final result =
        isObjectEmpty(json['items']) ? [] : t.fromList(json['items']);
    return Page<T>(
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      items: result,
    );
  }

  Page<T> copyWith({
    int? currentPage,
    int? pageSize,
    int? totalPages,
    int? totalItems,
    List? items,
  }) {
    return Page<T>(
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      items: items ?? this.items,
    );
  }

  Page<T> append({
    int? currentPage,
    int? pageSize,
    int? totalPages,
    int? totalItems,
    List? items,
  }) {
    return Page<T>(
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      items: (this.items ?? [])..addAll(items ?? []),
    );
  }

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);


  // List<Page<T>> fromList(List items) {
  //   if (items.isEmpty) {
  //     return [];
  //   } else {
  //     return items.map((e) => Page<T>.fromJson(e)).toList();
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
