import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/header_data.dart';
import '../../../domain/model/request_model/dynamic_component_req_model.dart';
import '../../../domain/usecase/utility_usecases.dart';
import '../../../main.dart';
import '../../../util/resource.dart';
import '../../../util/utility_variables.dart';
import '../../custom_view/custom_dialog.dart';


class DynamicPageViewController extends GetxController {
  final _utilityUsecase = getIt<UtilityUsecases>();
  // Use the global components list from UtilityVariables
  RxList<dynamic> get components => UtilityVariables.componentsVariableList;

  final _isLoading = false.obs;
  void loading(bool value) {
    if (value && !_isLoading.value) {
      CustomDialog.showLoadingDialog();
    } else if (!value && _isLoading.value) {
      Get.back();
    }
    _isLoading.value = value;
  }
  // Delete a component from the list
  void deleteComponent(int index) {
    components.removeAt(index); // Remove the component at the specified index
    Get.snackbar(
      'Deleted',
      'Component has been deleted successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void sendDynamicComponentRequest() {
    final reqBody = DynamicComponentReqModel(
      pageType: UtilityVariables.selectedPageType.value,
      label: UtilityVariables.pageName.value,
      components: UtilityVariables.componentsVariableList.toList(),
    );

    _utilityUsecase.dynamicComponentUsecase(HeaderData.headerPublic, reqBody).listen((resource) {
      switch (resource.status) {
        case Status.loading:
          //loading(true);
          break;
        case Status.success:
          final resData = resource.data!;
         // loading(false);

          debugPrint("dynamic_component_response $resData");

          CustomDialog.showSuccess('Request sent successfully!');
          break;
        case Status.error:
          //loading(false);
          CustomDialog.showError('${resource.errorMessage}');
          break;
      }
    });
  }


}
