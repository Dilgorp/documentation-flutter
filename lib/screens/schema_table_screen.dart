import 'package:documentation/constants/colors.dart';
import 'package:documentation/controllers/schema/schema_table_controller.dart';
import 'package:documentation/widgets/schema/category/select_category_list_widget.dart';
import 'package:documentation/widgets/schema/schema_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchemaTableScreen extends GetView<SchemaTableScreenController> {
  const SchemaTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: kBackgroundColor,
      body: Row(
        children: [
          Expanded(
            flex: 15,
            child: Column(
              children: [
                SelectCategoryListWidget(),
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 85,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SchemaTableWidget()],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
