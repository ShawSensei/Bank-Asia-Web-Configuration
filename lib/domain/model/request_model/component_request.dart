class ComponentRequest {
  final String type;
  final String label;
  final Map<String, dynamic>? image; // Store the icon map
  final String? utilityName;
  final String? utilityType;
  final String? utilityIcon;
  final String? utilityCode;
  final String? value;
  final String? placeholder;
  final String? required;
  final String? validationMsg;
  final String? items;
  final String? selectedItem;
  final String? actionType;
  final String? url;
  final String? method;

  ComponentRequest({
    required this.type,
    required this.label,
    this.image,
    this.utilityName,
    this.utilityType,
    this.utilityIcon,
    this.utilityCode,
    this.value,
    this.placeholder,
    this.required,
    this.validationMsg,
    this.items,
    this.selectedItem,
    this.actionType,
    this.url,
    this.method,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'label': label,
      if (image != null)
        'image': {
          'image': image!['image'], // Convert IconData to codePoint
          'label': image!['label']
        },
      if (image != null) 'image': image,

      if (utilityName != null) 'utilityName': utilityName,
      if (utilityType != null) 'utilityType': utilityType,
      if (utilityIcon != null) 'utilityIcon': utilityIcon,
      if (utilityCode != null) 'utilityCode': utilityCode,
      if (value != null) 'value': value,
      if (placeholder != null) 'placeholder': placeholder,
      if (required != null) 'required': required,
      if (validationMsg != null) 'validationMsg': validationMsg,
      if (items != null) 'items': items,
      if (selectedItem != null) 'selectedItem': selectedItem,
      if (actionType != null) 'actionType': actionType,
      if (url != null) 'url': url,
      if (method != null) 'method': method,
    };
  }

}
