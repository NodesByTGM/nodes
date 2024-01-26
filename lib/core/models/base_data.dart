import 'package:equatable/equatable.dart';

abstract class BaseData extends Equatable {
  const BaseData();

  @override
  List<dynamic> get props => [];
  List<dynamic> fromList(List<dynamic> items) => [];
}