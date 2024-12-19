// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilities_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtilitiesDto _$UtilitiesDtoFromJson(Map<String, dynamic> json) => UtilitiesDto(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      utilities: (json['utilities'] as List<dynamic>?)
          ?.map((e) => UtilityDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UtilitiesDtoToJson(UtilitiesDto instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'utilities': instance.utilities,
    };

UtilityDto _$UtilityDtoFromJson(Map<String, dynamic> json) => UtilityDto(
      utilityCode: json['utilityCode'] as String?,
      utilityName: json['utilityName'] as String?,
      utilityIcon: json['utilityIcon'] as String?,
      billers: (json['billers'] as List<dynamic>?)
          ?.map((e) => BillerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UtilityDtoToJson(UtilityDto instance) =>
    <String, dynamic>{
      'utilityCode': instance.utilityCode,
      'utilityName': instance.utilityName,
      'utilityIcon': instance.utilityIcon,
      'billers': instance.billers,
    };

BillerDto _$BillerDtoFromJson(Map<String, dynamic> json) => BillerDto(
      utilityCode: json['utilityCode'] as String?,
      utilityName: json['utilityName'] as String?,
      billerCode: json['billerCode'] as String?,
      billerName: json['billerName'] as String?,
      billerIcon: json['billerIcon'] as String?,
    );

Map<String, dynamic> _$BillerDtoToJson(BillerDto instance) => <String, dynamic>{
      'utilityCode': instance.utilityCode,
      'utilityName': instance.utilityName,
      'billerCode': instance.billerCode,
      'billerName': instance.billerName,
      'billerIcon': instance.billerIcon,
    };
