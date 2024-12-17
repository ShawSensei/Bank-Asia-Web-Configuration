import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/view/dashboard/add_page_screen.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';



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