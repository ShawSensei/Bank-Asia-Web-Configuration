import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/model/request_model/page_info.dart';
import '../../../domain/model/response_model/page_response.dart';
import '../../controller/controller/add_page_controller.dart';

import '../screen_type_selection/screen_type_selection.dart';

class PageList extends StatelessWidget {
  final AddPageController componentController = Get.put(AddPageController());

  PageList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Obx(() {
            return componentController.pageList.isEmpty
                ? SizedBox(
              height: 100,
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.teal.shade200, width: 1.5),
                ),
                child: const Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            )
                : Card(
              elevation: 8,
              margin: const EdgeInsets.all(5.0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.teal.shade200, width: 1.5),
              ),
              child: Column(
                children: componentController.pageList
                    .asMap()
                    .map((index, page) {
                  return MapEntry(
                    index,
                    Dismissible(
                      key: Key(page.id!),
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
                        componentController.deleteComponent(page.id!);
                        componentController.pageList.removeAt(index);

                        Get.snackbar(
                          'Deleted',
                          '${page.pageName} has been deleted',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _buildPageWidget(context, page),
                      ),
                    ),
                  );
                })
                    .values
                    .toList(),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPageWidget(BuildContext context, PageResponse page) {
    return GestureDetector(
      onTap: () {
        // Replace this with navigation to your desired page
        final info = PageInfo(
          pageName: page.pageName,
          pageRoute: page.pageRoute,
        );
        // Example: Navigate to a new screen with page details
        Get.to(() =>
            ScreenTypeSelection(
                 pageInfo: info
               ),
        );
        // HomeScreen(pageInfo: info));

      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.teal,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.pages,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${page.pageName} Page',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
