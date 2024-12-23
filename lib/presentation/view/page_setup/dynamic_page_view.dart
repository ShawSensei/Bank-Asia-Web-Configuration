import 'package:flutter/material.dart';
import 'package:flutter_web/domain/model/request_model/dynamic_single_page_req_model.dart';
import 'package:flutter_web/presentation/custom_view/custom_buttons.dart';
import 'package:get/get.dart';


import '../../controller/controller/dynamic_page_view_controller.dart';

class DynamicPageView extends StatelessWidget {
  const DynamicPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final DynamicPageViewController componentController = Get.put(DynamicPageViewController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              return componentController.components.isEmpty
                  ? Center(
                child: SizedBox(
                  height: 100,
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.teal.shade200, width: 1.5),
                    ),
                    child: const Center(child: Text('No Data Found')),
                  ),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: componentController.components.length,
                itemBuilder: (context, index) {
                  final DynamicSinglePageReqModel component = componentController.components[index];

                  return Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      // Delete component from the list
                      componentController.deleteComponent(index);

                      // Show Snackbar for confirmation
                      Get.snackbar(
                        'Deleted',
                        '${component.type ?? "Item"} has been deleted',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildComponentWidget(component),
                    ),
                  );
                },
              );
            }),
const SizedBox(height: 10),
            CustomElevatedButton(
                onPressed:()=>componentController.sendDynamicComponentRequest(),
                buttonText: 'Save page Layout',)
          ],
        )
      ),
    );
  }

  Widget _buildComponentWidget(DynamicSinglePageReqModel component) {
    switch (component.type) {
      case 'Text':
        return Center(
          child: Text(
            component.label ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        );
      case 'EditText':
        final RxString value = ''.obs;
        value.value = component.value ?? ''; // Initialize with the existing value

        return Obx(() {
          return TextFormField(
            initialValue: value.value,
            decoration: InputDecoration(
              labelText: component.label ?? 'Label',
              hintText: component.placeholder ?? 'Enter text',
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal.shade200),
              ),
            ),
            onChanged: (text) {
              value.value = text; // Update the reactive value
            },
            validator: (text) {
              // If the 'required' value is "Yes", the field is required
              if (component.required == "Yes") {
                if (text == null || text.isEmpty) {
                  return component.validationMsg ?? 'This field is required';
                }
              }
              return null; // Valid input or not required
            },
          );

        });
      case 'Button':
        return ElevatedButton(
          onPressed: (component.required == "Yes")
              ? () {
            // Add your button action logic here
          }
              : null, // Disable button if not required
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          child: Text(component.label ?? 'Button'),
        );

      case 'Dropdown':
      // Split the comma-separated string into a list of strings
        final items = (component.items is String
            ? (component.items as String).split(',') // Split by comma
            : [])
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList();

        return DropdownButtonFormField<String>(
          value: component.value,
          decoration: InputDecoration(
            labelText: component.label ?? 'Select Item',
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.teal.shade200),
            ),
          ),
          items: items,
          onChanged: (value) {
            // Handle dropdown selection
          },
        );




      case 'Checkbox':
        return Row(
          children: [
            Checkbox(
              value: component.value == 'true',
              onChanged: (value) {
                // Handle checkbox value change
              },
              activeColor: Colors.redAccent,
            ),
            Text(
              component.label ?? 'Checkbox',
              style: const TextStyle(fontSize: 16, color: Colors.teal),
            ),
          ],
        );


      case 'Radio Button':
        return Column(
          children: [
            // Check if the items is a valid string
            if (component.items != null && component.items is String)
            // Split the string by commas, trim spaces and create radio buttons
              ...(component.items as String)
                  .split(',')
                  .map((item) => Row(
                children: [
                  Radio<String>(
                    value: item.trim(),
                    groupValue: component.selectedItem,
                    onChanged: (value) {
                      // Handle the radio button change
                    },
                    activeColor: Colors.teal,
                  ),
                  Text(
                    item.trim(),
                    style: const TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                ],
              ))
                  .toList()
            else
              const Text(
                'No radio button options available',
                style: TextStyle(color: Colors.red),
              ),
          ],
        );






      default:
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Unknown Component Type'),
        );


    }
  }
}
