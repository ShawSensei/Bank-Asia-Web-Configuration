import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../controller/controller/screen_selection_controller.dart';
import '../../controller/controller/utility_input_controller.dart';


class UtilityInputComponent extends StatelessWidget {
  final UtilityInputController _controller = Get.put(UtilityInputController());

  final PageInfo pageInfo;

  UtilityInputComponent({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {

    final screenController = Get.put(ScreenSelectionController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.teal.shade200, width: 1.5),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


                // Enter Label Field
                Obx(() {
                  if (screenController.selectedPageType.value!.isNotEmpty) {
                    return _buildTextField(
                      controller: _controller.labelTextFieldController,
                      labelText: 'Enter label',
                    );
                  }
                  return Container();
                }),
                // Utility Type Dropdown
    Obx(() {
      return
        DropdownButtonFormField<String>(
          value: _controller.selectedUtilityTypeValue.value.isEmpty
              ? null
              : _controller.selectedUtilityTypeValue.value,
          hint: const Text("Select Utility Type"),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _controller.selectedUtilityTypeValue.value = newValue;
            }
          },
          items: _controller.utilityTypeItems
              .map((String value) =>
              DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
              .toList(),
        );

    },
    ),
                const SizedBox(height: 10),

    Obx(() {
      return
        // Icons List Dropdown
        DropdownButtonFormField<Map<String, dynamic>>(
          value: _controller.selectedImageValue.value,
          hint: const Text("Select Icon"),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (Map<String, dynamic>? newValue) {
            if (newValue != null) {
              _controller.selectedImageValue.value = newValue;
            }
          },
          items: _controller.iconItems.map((item) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: item,
              child: Row(
                children: [
                  Icon(item['icon']),
                  const SizedBox(width: 10),
                  Text(item['label']),
                ],
              ),
            );
          }).toList(),
        );


    },),
                const SizedBox(height: 15),

                // Utility Name Input
                _buildTextField(
                  controller: _controller.utilityNameTextFieldController,
                  labelText: 'Enter Utility Name',
                  hintText: 'e.g. Main Line',
                ),
                const SizedBox(height: 10),

                // Save Button

                // ElevatedButton(
                //   onPressed: () => _controller.saveUtilityData(context, pageInfo),
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),

                ElevatedButton(
                  onPressed: () =>
                      _controller.saveUtilityData(context, pageInfo),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),


                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black87,
                  ),
                  child: const Text(
                    'Save Utility',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
  }) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}