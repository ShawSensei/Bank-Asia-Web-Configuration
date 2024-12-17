import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/web_header.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../controller/controller/screen_selection_controller.dart';
import '../page_setup/component_list.dart';
import '../page_setup/input_component.dart';
import '../page_setup/utility_input_component.dart';
import '../page_setup/utility_input_list.dart';

class ScreenTypeSelection extends StatelessWidget {
  final PageInfo pageInfo;

  const ScreenTypeSelection({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(ScreenSelectionController());

    return Scaffold(
      appBar: const WebHeader(),
      body: Column(
        children: [
          // Page Title
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Page Input",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          // Dropdown Section (outside the scrollable area)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedPageType.value,
                    decoration: InputDecoration(
                      labelText: "Select Page Type",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: const Text("Choose your Page Type"),
                    items: controller.pageTypes
                        .map((pageType) => DropdownMenuItem(
                      value: pageType,
                      child: Text(pageType),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.updateSelectedPageType(value);
                    },
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Scrollable Content Section
          Expanded(

            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 600, // Adjust as needed for layout
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Content Section
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
                          children: [
                            Obx(() {
                              if (controller.selectedPageType.value == "Utility Page") {
                                return UtilityInputComponent(pageInfo: pageInfo);
                              } else if (controller.selectedPageType.value == "Biller Page") {
                                return InputComponent(pageInfo: pageInfo);
                              } else {
                                return const Center(
                                  child: Text(
                                    "Please select a page type.",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
                          children: [
                            Obx(() {
                              if (controller.selectedPageType.value == "Utility Page") {
                                return  UtilityInputList(); // Display UtilityInputList
                              } else if (controller.selectedPageType.value == "Biller Page") {
                                return MyComponentList(pageInfo: pageInfo); // Display MyComponentList
                              } else {
                                return const Center(
                                  child: Text(
                                    "Please select a valid page type.",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
