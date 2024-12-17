import 'package:json_annotation/json_annotation.dart';

part 'utility_list_res_model.g.dart';

/// Top-level DTO that contains the list of utilities
@JsonSerializable()
class UtilityListResModel {
  final int statusCode;
  final String message;
  final List<Utility> utilities;

  UtilityListResModel({
    required this.statusCode,
    required this.message,
    required this.utilities,
  });

  // Factory method to deserialize JSON
  factory UtilityListResModel.fromJson(Map<String, dynamic> json) =>
      _$UtilityListResModelFromJson(json);

  // Method to serialize object back to JSON
  Map<String, dynamic> toJson() => _$UtilityListResModelToJson(this);
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

  // Factory method to deserialize JSON
  factory Utility.fromJson(Map<String, dynamic> json) => _$UtilityFromJson(json);

  // Method to serialize object back to JSON
  Map<String, dynamic> toJson() => _$UtilityToJson(this);
}

@JsonSerializable()
class Biller {
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

  // Factory method to deserialize JSON
  factory Biller.fromJson(Map<String, dynamic> json) => _$BillerFromJson(json);

  // Method to serialize object back to JSON
  Map<String, dynamic> toJson() => _$BillerToJson(this);
}
