

import 'package:flutter/material.dart';


import '../../../common/web_header.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../page_setup/component_list.dart';
import '../page_setup/input_component.dart';




class ComponentSelectionScreen extends StatelessWidget {
  // final HomeController _controller = Get.put(HomeController());
  final PageInfo pageInfo;
  const ComponentSelectionScreen({super.key,required this.pageInfo}); // Initialize the controller


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   const WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '${pageInfo.pageName} Page' ,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InputComponent(pageInfo: pageInfo,),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: MyComponentList(pageInfo: pageInfo,),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}