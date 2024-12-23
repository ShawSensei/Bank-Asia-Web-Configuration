// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_component_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicComponentReqModel _$DynamicComponentReqModelFromJson(
        Map<String, dynamic> json) =>
    DynamicComponentReqModel(
      pageType: json['pageType'] as String?,
      label: json['label'] as String?,
      components: (json['components'] as List<dynamic>)
          .map((e) =>
              DynamicSinglePageReqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DynamicComponentReqModelToJson(
        DynamicComponentReqModel instance) =>
    <String, dynamic>{
      'pageType': instance.pageType,
      'label': instance.label,
      'components': instance.components,
    };
