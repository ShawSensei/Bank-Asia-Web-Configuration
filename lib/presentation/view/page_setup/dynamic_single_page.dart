import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/model/request_model/page_info.dart';
import '../../controller/controller/dynamic_single_page_controller.dart';


class DynamicSinglePage extends StatelessWidget {
  final DynamicSinglePageController _controller = Get.put(DynamicSinglePageController());
  final PageInfo pageInfo;

  DynamicSinglePage({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 20),
                // Dropdown for selecting type
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: _controller.selectedDropdownValue.value.isEmpty
                        ? null
                        : _controller.selectedDropdownValue.value,
                    hint: const Text("Select type"),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                // Main wrapper to check for 'Dropdown' or 'Button' selection
                Obx(() {
                  if (['Dropdown', 'Button'].contains(_controller.selectedDropdownValue.value)) {
                    return Column(
                      children: [

                        // Dropdown for API selection
                        Obx(() {
                          return DropdownButtonFormField<String>(
                            value: _controller.isInitialApi.contains(_controller.selectedApiValue.value)
                                ? _controller.selectedApiValue.value
                                : null,
                            hint: const Text("Select if API is needed"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                _controller.selectedApiValue.value = newValue;
                              }
                            },
                            items: _controller.isInitialApi
                                .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                          );
                        }),

                        // Additional fields when  API is "Yes"
                        Obx(() {
                          if (_controller.selectedApiValue.value == "Yes") {
                            return Column(
                              children: [
                                const SizedBox(height: 10),
                                _buildTextField(
                                  controller: _controller.apiUrlTextFieldController,
                                  labelText: 'Please enter URL',
                                ),
                                const SizedBox(height: 10),
                                _buildDropdown(
                                  hint: 'Method',
                                  items: _controller.methodItems,
                                  value: _controller.selectedMethodValue.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _controller.selectedMethodValue.value = newValue;
                                    }
                                  },
                                ),
                              //  const SizedBox(height: 10),
                                // Input field for Request Body based on Method
                                if (['POST', 'PUT', 'DELETE'].contains(_controller.selectedMethodValue.value))
                                  _buildTextField(
                                    controller: _controller.requestBodyTextFieldController,
                                    labelText: 'Please enter request body',
                                  ),
                                const SizedBox(height: 10),
                                _buildDropdown(
                                  hint: 'Header Option',
                                  items: _controller.headerOptionItems,
                                  value: _controller.selectedHeaderOptionValue.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _controller.selectedHeaderOptionValue.value = newValue;
                                    }
                                  },
                                ),
                               // const SizedBox(height: 10),
                                // Input field for Header Body based on Header Option
                                if (_controller.selectedHeaderOptionValue.value == 'Private' ||
                                    _controller.selectedHeaderOptionValue.value == 'Public')
                                  _buildTextField(
                                    controller: _controller.headerBodyTextFieldController,
                                    labelText: _controller.selectedHeaderOptionValue.value == 'Private'
                                        ? 'Please enter Private header body'
                                        : 'Please enter Public header body',
                                  ),
                              ],
                            );
                          }
                          return Container();
                        }),
                      ],
                    );
                  }
                  return Container(); // Return an empty container if 'Dropdown' or 'Button' is not selected
                }),

                Obx(() {
                  if (['Dropdown', 'Button'].contains(_controller.selectedDropdownValue.value)) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        // Dropdown for third-party API selection
                        Obx(() {
                          return DropdownButtonFormField<String>(
                            value: _controller.isInitialApi.contains(_controller.selectedThirdPartyApiValue.value)
                                ? _controller.selectedThirdPartyApiValue.value
                                : null,
                            hint: const Text("Select if third-party API is needed"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                _controller.selectedThirdPartyApiValue.value = newValue;
                              }
                            },
                            items: _controller.isInitialApi
                                .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                          );
                        }),

                        // Additional fields when third-party API is "Yes"
                        Obx(() {
                          if (_controller.selectedThirdPartyApiValue.value == "Yes") {
                            return Column(
                              children: [
                                const SizedBox(height: 10),
                                _buildTextField(
                                  controller: _controller.thirdPartyApiUrlTextFieldController,
                                  labelText: 'Please enter third-party API URL',
                                ),
                                const SizedBox(height: 10),
                                _buildDropdown(
                                  hint: 'Method',
                                  items: _controller.methodItems,
                                  value: _controller.selectedThirdPartyMethodValue.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _controller.selectedThirdPartyMethodValue.value = newValue;
                                    }
                                  },
                                ),
                                // Input field for Request Body based on Method
                                if (['POST', 'PUT', 'DELETE'].contains(_controller.selectedThirdPartyMethodValue.value))
                                  _buildTextField(
                                    controller: _controller.thirdPartyRequestBodyTextFieldController,
                                    labelText: 'Please enter third-party request body',
                                  ),
                                const SizedBox(height: 10),
                                _buildDropdown(
                                  hint: 'Header Option',
                                  items: _controller.headerOptionItems,
                                  value: _controller.selectedThirdPartyHeaderOptionValue.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _controller.selectedThirdPartyHeaderOptionValue.value = newValue;
                                    }
                                  },
                                ),
                                // Input field for Header Body based on Header Option
                                if (_controller.selectedThirdPartyHeaderOptionValue.value == 'Private' ||
                                    _controller.selectedThirdPartyHeaderOptionValue.value == 'Public')
                                  _buildTextField(
                                    controller: _controller.thirdPartyHeaderBodyTextFieldController,
                                    labelText: _controller.selectedThirdPartyHeaderOptionValue.value == 'Private'
                                        ? 'Please enter Private header body'
                                        : 'Please enter Public header body',
                                  ),
                              ],
                            );
                          }
                          return Container();
                        }),
                      ],
                    );
                  }
                  return Container(); // Return an empty container if 'Dropdown' or 'Button' is not selected
                }),




                const SizedBox(height: 10),

                // Show fields based on dropdown selection
                // Obx(() {
                //   if (_controller.selectedDropdownValue.value == 'Button') {
                //     return Column(
                //       children: [
                //         DropdownButtonFormField<String>(
                //           value: _controller.selectedActionTypeValue.value.isEmpty
                //               ? null
                //               : _controller.selectedActionTypeValue.value,
                //           hint: const Text("Action Type"),
                //           decoration: InputDecoration(
                //             contentPadding:
                //             const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //           ),
                //           onChanged: (String? newValue) {
                //             if (newValue != null) {
                //               _controller.selectedMethodValue.value = "";
                //               _controller.selectedActionTypeValue.value =
                //                   newValue; // Update dropdown value
                //             }
                //           },
                //           items: _controller.actionTypeItems.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //         ),
                //         const SizedBox(height: 10),
                //
                //         // Display TextFields based on selectedActionTypeValue
                //         if (_controller.selectedActionTypeValue.value == 'API Call' ||
                //             _controller.selectedActionTypeValue.value == 'Navigation') ...[
                //           TextField(
                //             controller: _controller.urlTextFieldController,
                //             decoration: InputDecoration(
                //               labelText: _controller.selectedActionTypeValue.value ==
                //                   'API Call'
                //                   ? 'Enter Url'
                //                   : 'Enter navigation page name',
                //               hintText: _controller.selectedActionTypeValue.value ==
                //                   'API Call'
                //                   ? 'Please enter your URL (e.g. read/login)'
                //                   : 'Please enter your page name',
                //               contentPadding:
                //               const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(height: 10),
                //         ],
                //         if (_controller.selectedActionTypeValue.value == 'API Call') ...[
                //           DropdownButtonFormField<String>(
                //             value: _controller.selectedMethodValue.value.isEmpty
                //                 ? null
                //                 : _controller.selectedMethodValue.value,
                //             hint: const Text("Enter Method"),
                //             decoration: InputDecoration(
                //               contentPadding:
                //               const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //             ),
                //             onChanged: (String? newValue) {
                //               if (newValue != null) {
                //                 _controller.selectedMethodValue.value =
                //                     newValue; // Update dropdown value
                //               }
                //             },
                //             items: _controller.methodItems.map((String value) {
                //               return DropdownMenuItem<String>(
                //                 value: value,
                //                 child: Text(value),
                //               );
                //             }).toList(),
                //           ),
                //           const SizedBox(height: 10),
                //         ],
                //       ],
                //     );
                //   }
                //   return Container();
                // }),

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
                }
                ),
                Obx(() {
                  if (['InputField', 'Dropdown']
                      .contains(_controller.selectedDropdownValue.value)) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildTextField(
                        controller: _controller.validationFieldController,
                        labelText: 'Validation error message',
                      ),]
                    );
                  }
                  return Container();
                }),

                Obx(() {
                  if (['Radio Button', 'Dropdown']
                      .contains(_controller.selectedDropdownValue.value)) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _controller.itemsTextFieldController,
                          labelText: 'Enter items with comma separator',
                          hintText: 'Please write with comma separator (e.g. C,C++,Java)',
                        ),
                        const SizedBox(height: 10),
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


                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () => _controller.saveData(context),
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
        ),
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
