class UtilityReqModel{
  final String? categoryCode;
  final String? subcategoryCode;

  UtilityReqModel({ this.categoryCode,  this.subcategoryCode});

  Map<String, dynamic> toJson() {
    return {
      'categoryCode': categoryCode,
      'subcategoryCode': subcategoryCode,
    };
  }
}