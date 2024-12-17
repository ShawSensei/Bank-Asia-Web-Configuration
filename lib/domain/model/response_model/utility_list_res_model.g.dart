// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utility_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtilityListResModel _$UtilityListResModelFromJson(Map<String, dynamic> json) =>
    UtilityListResModel(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      utilities: (json['utilities'] as List<dynamic>)
          .map((e) => Utility.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UtilityListResModelToJson(
        UtilityListResModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'utilities': instance.utilities,
    };

Utility _$UtilityFromJson(Map<String, dynamic> json) => Utility(
      utilityCode: json['utilityCode'] as String?,
      utilityName: json['utilityName'] as String?,
      utilityIcon: json['utilityIcon'] as String?,
      billers: (json['billers'] as List<dynamic>?)
          ?.map((e) => Biller.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UtilityToJson(Utility instance) => <String, dynamic>{
      'utilityCode': instance.utilityCode,
      'utilityName': instance.utilityName,
      'utilityIcon': instance.utilityIcon,
      'billers': instance.billers,
    };

Biller _$BillerFromJson(Map<String, dynamic> json) => Biller(
      utilityCode: json['utilityCode'] as String?,
      utilityName: json['utilityName'] as String?,
      billerCode: json['billerCode'] as String?,
      billerName: json['billerName'] as String?,
      billerIcon: json['billerIcon'] as String?,
    );

Map<String, dynamic> _$BillerToJson(Biller instance) => <String, dynamic>{
      'utilityCode': instance.utilityCode,
      'utilityName': instance.utilityName,
      'billerCode': instance.billerCode,
      'billerName': instance.billerName,
      'billerIcon': instance.billerIcon,
    };
