import 'package:json_annotation/json_annotation.dart';

part 'utility_data_model.g.dart';

@JsonSerializable()
class UtilityDataModel {
  final int? statusCode;
  final String? message;
  final List<Utility>? utilities;

  UtilityDataModel({
    this.statusCode,
    this.message,
    this.utilities,
  });

  factory UtilityDataModel.fromJson(Map<String, dynamic> json) =>
      _$UtilityDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UtilityDataModelToJson(this);
}

@JsonSerializable()
class Utility {
  final String? utilityCode;
  final String? utilityName;
  final String? utilityIcon;
  final List<Biller>? billers;

  Utility({
    this.utilityCode,
    this.utilityName,
    this.utilityIcon,
    this.billers,
  });

  factory Utility.fromJson(Map<String, dynamic> json) =>
      _$UtilityFromJson(json);

  Map<String, dynamic> toJson() => _$UtilityToJson(this);
}

@JsonSerializable()
class Biller{
  final String? utilityCode;
  final String? utilityName;
  final String? billerCode;
  final String? billerName;
  final String? billerIcon;

  Biller({
    this.utilityCode,
    this.utilityName,
    this.billerCode,
    this.billerName,
    this.billerIcon,
  });

  factory Biller.fromJson(Map<String, dynamic> json) =>
      _$BillerFromJson(json);

  Map<String, dynamic> toJson() => _$BillerToJson(this);
}
