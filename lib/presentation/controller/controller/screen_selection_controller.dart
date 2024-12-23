import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/utility_variables.dart';

class ScreenSelectionController extends GetxController {
  var pageTypes = ["Utility Page", "Biller Page", "Dynamic Single Page"].obs;
  var selectedPageType = Rx<String?>(null);
  final TextEditingController pageNameController = TextEditingController();
  final RxString pageName = ''.obs;

  void updateSelectedPageType(String? value) {
    selectedPageType.value = value;
    UtilityVariables.selectedPageType.value = value;
  }

  void updatePageName(String value) {
    pageName.value = value;
    UtilityVariables.pageName.value = value;
  }

  @override
  void onClose() {
    pageNameController.dispose();
    super.onClose();
  }
}
