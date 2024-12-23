import 'package:json_annotation/json_annotation.dart';

import 'dynamic_single_page_req_model.dart';

part 'dynamic_component_req_model.g.dart';

@JsonSerializable()
class DynamicComponentReqModel {
   final String? pageType;
  final String? label;
  final List<DynamicSinglePageReqModel> components;

  DynamicComponentReqModel({
    this.pageType,
     this.label,
    required this.components,
  });

  // Factory constructor to create an instance from JSON
  factory DynamicComponentReqModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicComponentReqModelFromJson(json);

  // Method to convert the instance into JSON
  Map<String, dynamic> toJson() => _$DynamicComponentReqModelToJson(this);
}
