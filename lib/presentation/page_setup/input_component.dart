import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../model/request_model/page_info.dart';

class InputComponent extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  final PageInfo pageInfo;

  InputComponent({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Utility Selection Dropdown
        Obx(() {
          return DropdownButtonFormField<Map<String, dynamic>>(
            value: _controller.selectedUtilityDropdownValue.value,
            hint: const Text("Select a Utility"),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (Map<String, dynamic>? newValue) {
              if (newValue != null) {
                _controller.selectedUtilityDropdownValue.value = newValue;
              }
            },
            items: _controller.utilityDropdownItems.map((item) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: item,
                child: IntrinsicHeight( // Ensures the layout adjusts
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(item['image']),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item['type'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            // Customizing the display of the selected item in the input box
            selectedItemBuilder: (BuildContext context) {
              return _controller.utilityDropdownItems.map((item) {
                return Row(
                  children: [
                    Icon(item['image']),
                    const SizedBox(width: 10),
                    Text(item['title']),
                  ],
                );
              }).toList();
            },
          );
        }),


        const SizedBox(height: 20),

        // Show Card or Placeholder Text Based on Selection
        Obx(() {
          if (_controller.selectedUtilityDropdownValue.value != null) {
            return Card(
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
                    // Dropdown for selecting type
                    Obx(() {
                      return DropdownButtonFormField<String>(
                        value: _controller.selectedDropdownValue.value.isEmpty
                            ? null
                            : _controller.selectedDropdownValue.value,
                        hint: const Text("Select type"),
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _controller.selectedDropdownValue.value = newValue;
                            _controller.selectedActionTypeValue.value = ""; // Reset dependent values
                          }
                        },
                        items: _controller.dropdownItems
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                      );
                    }),

                    const SizedBox(height: 10),

                    // Enter Label Field
                    Obx(() {
                      if (_controller.selectedDropdownValue.value.isNotEmpty) {
                        return _buildTextField(
                          controller: _controller.labelTextFieldController,
                          labelText: 'Enter label',
                        );

                      }
                      return Container();
                    }),
                    const SizedBox(height: 10),

                    // Show fields based on dropdown selection
                    Obx(() {
                      if (_controller.selectedDropdownValue.value == 'Button') {
                        return Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _controller.selectedActionTypeValue.value.isEmpty
                                  ? null
                                  : _controller.selectedActionTypeValue.value,
                              hint: const Text("Action Type"),
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  _controller.selectedMethodValue.value = "";
                                  _controller.selectedActionTypeValue.value =
                                      newValue; // Update dropdown value
                                }
                              },
                              items: _controller.actionTypeItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),

                            // Display TextFields based on selectedActionTypeValue
                            if (_controller.selectedActionTypeValue.value == 'API Call' ||
                                _controller.selectedActionTypeValue.value == 'Navigation') ...[
                              TextField(
                                controller: _controller.urlTextFieldController,
                                decoration: InputDecoration(
                                  labelText: _controller.selectedActionTypeValue.value ==
                                      'API Call'
                                      ? 'Enter Url'
                                      : 'Enter navigation page name',
                                  hintText: _controller.selectedActionTypeValue.value ==
                                      'API Call'
                                      ? 'Please enter your URL (e.g. read/login)'
                                      : 'Please enter your page name',
                                  contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                            if (_controller.selectedActionTypeValue.value == 'API Call') ...[
                              DropdownButtonFormField<String>(
                                value: _controller.selectedMethodValue.value.isEmpty
                                    ? null
                                    : _controller.selectedMethodValue.value,
                                hint: const Text("Enter Method"),
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    _controller.selectedMethodValue.value =
                                        newValue; // Update dropdown value
                                  }
                                },
                                items: _controller.methodItems.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ],
                        );
                      }
                      return Container();
                    }),

                    Obx(() {
                      if (_controller.selectedDropdownValue.value == 'InputField') {
                        return Column(
                          children: [
                            TextField(
                              controller: _controller.valueTextFieldController,
                              decoration: InputDecoration(
                                labelText: 'Enter value',
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _controller.placeholderTextFieldController,
                              decoration: InputDecoration(
                                labelText: 'Enter placeholder',
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
                      return Container();
                    }),

                    Obx(() {
                      if (['InputField', 'Dropdown', 'Button']
                          .contains(_controller.selectedDropdownValue.value)) {
                        return _buildDropdown(
                          hint: _controller.selectedDropdownValue.value == 'Button'
                              ? "Is enabled"
                              : "Is required",
                          items: _controller.isRequiredItems,
                          value: _controller.selectedIsRequiredValue.value,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _controller.selectedIsRequiredValue.value = newValue;
                            }
                          },
                        );
                      }
                      return Container();
                    }),

                    Obx(() {
                      if (['InputField', 'Dropdown']
                          .contains(_controller.selectedDropdownValue.value)) {
                        return _buildTextField(
                          controller: _controller.validationFieldController,
                          labelText: 'Validation error message',
                        );
                      }
                      return Container();
                    }),

                    Obx(() {
                      if (['Radio Button', 'Dropdown']
                          .contains(_controller.selectedDropdownValue.value)) {
                        return Column(
                          children: [
                            _buildTextField(
                              controller: _controller.itemsTextFieldController,
                              labelText: 'Enter items with comma separator',
                              hintText: 'Please write with comma separator (e.g. C,C++,Java)',
                            ),
                            if (_controller.selectedDropdownValue.value == 'Dropdown')
                              _buildTextField(
                                controller: _controller.selectedItemTextFieldController,
                                labelText: 'Enter selected item',
                                hintText: 'Please enter item from your list',
                              ),
                          ],
                        );
                      }
                      return Container();
                    }),

                    Obx(() {
                      if (_controller.selectedDropdownValue.value == 'Utility') {
                        return Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _controller.selectedUtilityTypeValue.value.isEmpty
                                  ? null
                                  : _controller.selectedUtilityTypeValue.value,
                              hint: const Text("Select Utility Type"),
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  _controller.selectedUtilityTypeValue.value = newValue;
                                }
                              },
                              items: _controller.utilityTypeItems.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<Map<String, dynamic>>(
                              value: _controller.selectedImageValue.value,
                              hint: const Text("Select Icon"),
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              controller: _controller.utilityNameTextFieldController,
                              labelText: 'Enter Utility Name',
                              hintText: 'e.g. Main Line',
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }
                      return Container();
                    }),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () => _controller.saveData(context, pageInfo),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black87,
                      ),
                      child: const Text(
                        'Add Data',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],

                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'Please select a utility name',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }),
      ],
    );
  }

  // Helper method for creating TextField widgets
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String value,
    required void Function(String?) onChanged,
  }) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint, style: const TextStyle(color: Colors.black87)),
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: onChanged,
          items: items
              .map((String item) =>
              DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
              .toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
  }
