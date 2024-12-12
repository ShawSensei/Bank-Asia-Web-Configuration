import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/dashboard/add_page_screen.dart';
import 'package:flutter_web/presentation/page_setup/home_screen.dart';
import 'package:flutter_web/presentation/screen_type_selection/screen_type_selection.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'model/request_model/page_info.dart';

void main() {
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
      //const AddPageScreen()
      ScreenTypeSelection(
        pageInfo: PageInfo(
          pageName: 'Placeholder',
          pageRoute: '/placeholder', // Default route
        ),
      ),
    );
  }
}