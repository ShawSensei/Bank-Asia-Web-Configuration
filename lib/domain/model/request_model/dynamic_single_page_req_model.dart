import 'package:json_annotation/json_annotation.dart';

part 'dynamic_single_page_req_model.g.dart';

@JsonSerializable()
class DynamicSinglePageReqModel {
  final String type;
  final String? label;
  final String? value;
  final String? placeholder;
  final String? required;
  final String? validationMsg;
  final dynamic items;
  final String? selectedItem;
  final String? actionType;
  final String? url;
  final String? method;
  final String? apiUrl;
  final String? requestBody;
  final String? headerBody;
  final String? selectedHeaderOption;

  // New third-party API fields
  final String? thirdPartyApiUrl;
  final String? thirdPartyRequestBody;
  final String? thirdPartyHeaderBody;
  final String? selectedThirdPartyMethod;
  final String? selectedThirdPartyHeaderOption;

  DynamicSinglePageReqModel({
    required this.type,
    this.label,
    this.value,
    this.placeholder,
    this.required,
    this.validationMsg,
    this.items,
    this.selectedItem,
    this.actionType,
    this.url,
    this.method,
    this.apiUrl,
    this.requestBody,
    this.headerBody,
    this.selectedHeaderOption,
    // Third-party API fields
    this.thirdPartyApiUrl,
    this.thirdPartyRequestBody,
    this.thirdPartyHeaderBody,
    this.selectedThirdPartyMethod,
    this.selectedThirdPartyHeaderOption,
  });

  factory DynamicSinglePageReqModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicSinglePageReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicSinglePageReqModelToJson(this);
}
