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

  // New fields from the updated response
  final String? buttonType; // New field for buttonType
  final String? hint; // New field for hint (for inputField type)
  final String? regex; // New field for regex (for inputField type)
  final bool? hasSampleButton; // New field for hasSampleButton
  final String? sampleImage; // New field for sampleImage (for buttons)

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
    this.buttonType,
    this.hint,
    this.regex,
    this.hasSampleButton,
    this.sampleImage,
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

      // New fields from the updated response
      buttonType: json['buttonType'] as String?,
      hint: json['hint'] as String?,
      regex: json['regex'] as String?,
      hasSampleButton: json['hasSampleButton'] as bool?,
      sampleImage: json['sampleImage'] as String?,
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

      // New fields for button type components
      'buttonType': buttonType,
      'hint': hint,
      'regex': regex,
      'hasSampleButton': hasSampleButton,
      'sampleImage': sampleImage,
    };
  }

  bool get isRequired => required ?? false;
  String get validationMessage => validationMsg ?? 'This field is required';
  bool get isEnabled => required ?? false;

  // Additional getter for buttons to identify if URL exists
  bool get isButtonWithUrl => (buttonType != null && url != null);
}
