import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/view/page_setup/input_component.dart';
import 'package:get/get.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../../domain/model/response_model/utility_data_model.dart';
import '../../controller/controller/utility_list_controller.dart';
import '../screen_type_selection/component_selection_screen.dart';

class UtilityInputList extends StatelessWidget {
  // Using Get.put to manage the controller and initialize it
  final UtilityListController _controller = Get.put(
    UtilityListController(
      PageInfo(pageRoute: "yourPageRoute"), // Replace "yourPageRoute" with the actual route
    ),
  );

  UtilityInputList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Wrap in a scrollable view to avoid constraints issues
      child: Column(
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
                  Obx(() {
                    // This will reactively display utilities or a "No utilities saved yet" message
                    if (_controller.utilitiesList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No utilities saved yet.",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true, // Use shrinkWrap to avoid layout issues
                        itemCount: _controller.utilitiesList.length,
                        itemBuilder: (context, index) {
                          final utility = _controller.utilitiesList[index];
                          return _buildUtilityCard(utility, index);
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build each utility card in the list
  Widget _buildUtilityCard(Utility utility, int index) {
    // Decode the base64 icon string into an IconData
    final iconData = utility.utilityIcon != null
        ? _controller.decodeBase64ToIconData(utility.utilityIcon!)
        : Icons.device_unknown; // Default icon if none is available


    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(
            iconData,
            color: Colors.blue.shade600,
            size: 30,
          ),
        ),
        title: Text(
          utility.utilityName ?? "Unknown Utility",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          utility.utilityCode ?? "Unknown Code",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            // Delete the utility and trigger a UI update
            _controller.deleteUtility(index);
          },

        ),
        onTap: () {
          // Navigate to UtilityInputComponent and pass utility as argument
          Get.to(
                () => ComponentSelectionScreen(
              pageInfo: PageInfo(pageRoute: "utilityDetail"),
            ),
            arguments: utility, // Pass the selected utility as an argument
          );
        },
      ),
    );
  }
}