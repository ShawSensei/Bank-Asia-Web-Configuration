import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/component_controller.dart';
import '../../model/request_model/page_info.dart';
import '../../model/response_model/component_response.dart';

class MyComponentList extends StatelessWidget {
  final PageInfo pageInfo;

  const MyComponentList({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {
    final ComponentController componentController =
    Get.put(ComponentController(pageInfo));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
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
              final ComponentResponse component =
              componentController.components[index];

              return Dismissible(
                key: Key(component.id ?? index.toString()),
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
                  componentController.deleteComponent(
                    component.id ?? '',
                    pageInfo,
                  );
                  componentController.components.removeAt(index);

                  Get.snackbar(
                    'Deleted',
                    '${component.name ?? "Item"} has been deleted',
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
      ),
    );
  }

  Widget _buildComponentWidget(ComponentResponse component) {
    switch (component.type) {
      case 'Text':
        return Center(
          child: Text(
            component.name ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        );
      case 'EditText':
        final RxString value = ''.obs;
        value.value = component.  value ?? ''; // Initialize with the existing value

        return Obx(() {
          return TextFormField(
            initialValue: value.value,
            decoration: InputDecoration(
              labelText: component.name ?? 'Label',
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
              if ((component.isRequired ?? false) && (text == null || text.isEmpty)) {
                return component.validationMessage ?? 'This field is required';
              }
              return null;
            },
          );
        });

      case 'Button':
        return ElevatedButton(
          onPressed: (component.isEnabled ?? true)
              ? () {
            // Add your button action logic here
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          child: Text(component.name ?? 'Button'),
        );
      case 'Dropdown':
        final items = (component.items ?? [])
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList();
        return DropdownButtonFormField<String>(
          value: component.value,
          decoration: InputDecoration(
            labelText: component.name ?? 'Select Item',
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
            ),
            Text(
              component.name ?? 'Checkbox',
              style: const TextStyle(fontSize: 16, color: Colors.teal),
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

