
import 'package:json_annotation/json_annotation.dart';

part 'reg_info_dto.g.dart';

@JsonSerializable()
class RegInfoDto {
  final String? action;
  final String? url;

  RegInfoDto({
    this.action,
    this.url,
  });

  factory RegInfoDto.fromJson(Map<String, dynamic> json) =>
      _$RegInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegInfoDtoToJson(this);
}