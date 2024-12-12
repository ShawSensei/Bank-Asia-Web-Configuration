class ComponentResponse {
  final String? id;
  final String? name;
  final String? type;
  final Map<String, dynamic>? icon;
  final String? utilityName;
  final String? utilityType;
  final dynamic details;
  final String? label;
  final String? value;
  final bool? required;
  final String? placeholder;
  final String? validationMsg;
  final String? url;
  final String? method;
  final int? selectedValue;
  final dynamic items;

  ComponentResponse({
    this.id,
    this.name,
    this.type,
    this.icon,
    this.utilityName,
    this.utilityType,
    this.details,
    this.label,
    this.value,
    this.required,
    this.placeholder,
    this.validationMsg,
    this.url,
    this.method,
    this.selectedValue,
    this.items,
  });

  factory ComponentResponse.fromJson(Map<String, dynamic> json) {
    return ComponentResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      icon: json['icon'],
      utilityName: json['utilityName'] as String?,
      utilityType: json['utilityType'] as String?,
      details: json['details'],
      label: json['label'] as String?,
      value: json['value'] as String?,
      required: json['required'] == 'Yes' || json['required'] == true,
      placeholder: json['placeholder'] as String?,
      validationMsg: json['validationMsg'] as String?,
      url: json['url'] as String?,
      method: json['method'] as String?,
      selectedValue: json['selectedValue'] as int?,
      items: json['items'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'icon': icon,
      'utilityName': utilityName,
      'utilityType': utilityType,
      'details': details,
      'label': label,
      'value': value,
      'required': required,
      'placeholder': placeholder,
      'validationMsg': validationMsg,
      'url': url,
      'method': method,
      'selectedValue': selectedValue,
      'items': items,
    };
  }

  bool get isRequired => required ?? false;
  String get validationMessage => validationMsg ?? 'This field is required';
  bool get isEnabled => required ?? false;
}
