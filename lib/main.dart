import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/controller/controller/utility_list_controller.dart';
import 'package:flutter_web/presentation/view/dashboard/add_page_screen.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';

import 'di/utility_module.dart';
import 'domain/model/request_model/page_info.dart';


final getIt = GetIt.instance;
void main() {

  UtilityModule.dependencies();
  Get.put(UtilityListController(PageInfo()));

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Server Driven UI Setting Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      const AddPageScreen()
      // ScreenTypeSelection(
      //   pageInfo: PageInfo(
      //     pageName: 'Placeholder',
      //     pageRoute: '/placeholder', // Default route
      //   ),
      // ),
    );
  }
}