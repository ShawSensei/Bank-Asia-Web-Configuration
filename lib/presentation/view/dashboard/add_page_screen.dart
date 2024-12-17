
import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/view/dashboard/page_list.dart';

import '../../../common/web_header.dart';
import 'input_page.dart';


class AddPageScreen extends StatelessWidget {
  const AddPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: const WebHeader(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Page input",
                    style: TextStyle(
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
                        child: InputPage(),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: PageList(),
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
