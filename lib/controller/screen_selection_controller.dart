import 'package:get/get.dart';

class ScreenSelectionController extends GetxController {
  // Observable list of page types
  var pageTypes = ["Utility Page", "Biller Page"].obs; // Use RxList for observables

  // Observable selected page type
  var selectedPageType = Rx<String?>(null);

  // Method to update the selected page type
  void updateSelectedPageType(String? value) {
    selectedPageType.value = value;
  }
}
