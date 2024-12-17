import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data_sources/api/api/ComponentService.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../controller/controller/utility_list_controller.dart';



class UtilityInputList extends StatelessWidget {
  // Pass the required arguments when creating the controller
  final UtilityListController _controller = Get.put(
    UtilityListController(
      PageInfo(pageRoute: "yourPageRoute"), // Replace "yourPageRoute" with the actual route
      ComponentService(),
    ),
  );

  UtilityInputList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
