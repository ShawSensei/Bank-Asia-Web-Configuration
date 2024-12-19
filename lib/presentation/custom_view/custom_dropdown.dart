import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.itemToString,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14.0),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(16),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            itemToString(value),
            style: const TextStyle(fontSize: 14.0),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class CustomDropdown2<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropdown2({
    super.key,
    required this.labelText,
    required this.items,
    required this.itemToString,
    this.selectedValue,
    this.onChanged,
    this.contentPadding
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14.0),
        border: const OutlineInputBorder(),
        contentPadding: contentPadding?? const EdgeInsets.only(left: 2.0,right: 10.0, bottom: 10.0,top: 10.0),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            itemToString(value),
            style: const TextStyle(fontSize: 14.0),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}