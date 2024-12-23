import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/view/page_setup/dynamic_single_page.dart';
import 'package:get/get.dart';

import '../../../common/web_header.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../controller/controller/screen_selection_controller.dart';
import '../page_setup/component_list.dart';
import '../page_setup/dynamic_page_view.dart';
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
          SizedBox(height: 20),
          // Dropdown Section
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

          // Page Name Input Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextFormField(
              controller: controller.pageNameController,
              decoration: InputDecoration(
                labelText: "Page Name",
                hintText: "Enter the name of the page",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                controller.updatePageName(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Page name is required.";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          // Scrollable Content Section
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Content Section
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (controller.selectedPageType.value == "Utility Page") {
                              return UtilityInputComponent(pageInfo: pageInfo);
                            } else if (controller.selectedPageType.value == "Biller Page") {
                              return InputComponent(pageInfo: pageInfo);
                            } else if (controller.selectedPageType.value == "Dynamic Single Page") {
                              return DynamicSinglePage(pageInfo: pageInfo);
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (controller.selectedPageType.value == "Utility Page") {
                              return UtilityInputList();
                            } else if (controller.selectedPageType.value == "Biller Page") {
                              return MyComponentList(pageInfo: pageInfo);
                            } else if (controller.selectedPageType.value == "Dynamic Single Page") {
                              return const DynamicPageView();
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
        ],
      )

    );
  }
}
