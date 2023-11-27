import 'package:documentation/constants/colors.dart';
import 'package:documentation/constants/strings.dart';
import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/schema/schema_controller.dart';
import 'package:documentation/widgets/common/drop_down_menu.dart';
import 'package:documentation/widgets/schema/items/schema_item_detail_widget.dart';
import 'package:documentation/widgets/schema/schema_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchemaScreen extends GetView<SchemaController> {
  const SchemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: controller.obx((state) {
          if (state == null) return kNoContentWidget;

          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                      child: PanelDropdownMenu(tag: kCategoriesTag),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 80,
                      child: SchemaWidget(),
                    ),
                    Visibility(
                      visible: state.schemaItem != null,
                      child: Expanded(
                        flex: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 0.0),
                            color: Colors.white,
                          ),
                          child: state.schemaItem == null
                              ? Container()
                              : const SchemaItemDetailWidget(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
