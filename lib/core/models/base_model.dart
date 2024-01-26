

import 'package:nodes/core/models/base_data.dart';

abstract class BaseModel extends BaseData {
  final String? id;

  const BaseModel({this.id});

  @override
  List<dynamic> get props => [id];
}