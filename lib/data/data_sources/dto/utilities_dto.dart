import 'package:json_annotation/json_annotation.dart';
import '../../../domain/model/response_model/utility_data_model.dart';

part 'utilities_dto.g.dart';

@JsonSerializable()
class UtilitiesDto {
  final int? statusCode;
  final String? message;
  final List<UtilityDto>? utilities;

  UtilitiesDto({
    this.statusCode,
    this.message,
    this.utilities,
  });

  factory UtilitiesDto.fromJson(Map<String, dynamic> json) =>
      _$UtilitiesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UtilitiesDtoToJson(this);

  // Convert DTO to Data Model
  UtilityDataModel toUtilityDataModel() {
    return UtilityDataModel(
      statusCode: statusCode,
      message: message,
      utilities: utilities?.map((u) => u.toUtility()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class UtilityDto {
  final String? utilityCode;
  final String? utilityName;
  final String? utilityIcon;
  final List<BillerDto>? billers;

  UtilityDto({
    this.utilityCode,
    this.utilityName,
    this.utilityIcon,
    this.billers,
  });

  factory UtilityDto.fromJson(Map<String, dynamic> json) =>
      _$UtilityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UtilityDtoToJson(this);

  // Convert DTO to Data Model
  Utility toUtility() {
    return Utility(
      utilityCode: utilityCode,
      utilityName: utilityName,
      utilityIcon: utilityIcon,
      billers: billers?.map((b) => b.toBiller()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class BillerDto {
  final String? utilityCode;
  final String? utilityName;
  final String? billerCode;
  final String? billerName;
  final String? billerIcon;

  BillerDto({
    this.utilityCode,
    this.utilityName,
    this.billerCode,
    this.billerName,
    this.billerIcon,
  });

  factory BillerDto.fromJson(Map<String, dynamic> json) =>
      _$BillerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BillerDtoToJson(this);

  // Convert DTO to Data Model
  Biller toBiller() {
    return Biller(
      utilityCode: utilityCode,
      utilityName: utilityName,
      billerCode: billerCode,
      billerName: billerName,
      billerIcon: billerIcon,
    );
  }
}
