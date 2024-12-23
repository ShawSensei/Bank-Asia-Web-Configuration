// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_single_page_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicSinglePageReqModel _$DynamicSinglePageReqModelFromJson(
        Map<String, dynamic> json) =>
    DynamicSinglePageReqModel(
      type: json['type'] as String,
      label: json['label'] as String?,
      value: json['value'] as String?,
      placeholder: json['placeholder'] as String?,
      required: json['required'] as String?,
      validationMsg: json['validationMsg'] as String?,
      items: json['items'],
      selectedItem: json['selectedItem'] as String?,
      actionType: json['actionType'] as String?,
      url: json['url'] as String?,
      method: json['method'] as String?,
      apiUrl: json['apiUrl'] as String?,
      requestBody: json['requestBody'] as String?,
      headerBody: json['headerBody'] as String?,
      selectedHeaderOption: json['selectedHeaderOption'] as String?,
      thirdPartyApiUrl: json['thirdPartyApiUrl'] as String?,
      thirdPartyRequestBody: json['thirdPartyRequestBody'] as String?,
      thirdPartyHeaderBody: json['thirdPartyHeaderBody'] as String?,
      selectedThirdPartyMethod: json['selectedThirdPartyMethod'] as String?,
      selectedThirdPartyHeaderOption:
          json['selectedThirdPartyHeaderOption'] as String?,
    );

Map<String, dynamic> _$DynamicSinglePageReqModelToJson(
        DynamicSinglePageReqModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'value': instance.value,
      'placeholder': instance.placeholder,
      'required': instance.required,
      'validationMsg': instance.validationMsg,
      'items': instance.items,
      'selectedItem': instance.selectedItem,
      'actionType': instance.actionType,
      'url': instance.url,
      'method': instance.method,
      'apiUrl': instance.apiUrl,
      'requestBody': instance.requestBody,
      'headerBody': instance.headerBody,
      'selectedHeaderOption': instance.selectedHeaderOption,
      'thirdPartyApiUrl': instance.thirdPartyApiUrl,
      'thirdPartyRequestBody': instance.thirdPartyRequestBody,
      'thirdPartyHeaderBody': instance.thirdPartyHeaderBody,
      'selectedThirdPartyMethod': instance.selectedThirdPartyMethod,
      'selectedThirdPartyHeaderOption': instance.selectedThirdPartyHeaderOption,
    };
