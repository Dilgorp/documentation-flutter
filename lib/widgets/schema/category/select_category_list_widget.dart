import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/common/selected_items_list_controller.dart';
import 'package:documentation/model/category/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoryListWidget
    extends GetView<SelectedItemsListController<Category>> {
  const SelectCategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return kNoContentWidget;

      return Column(
        children: [
          Container(
            constraints: _kListBoxConstraints,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.items.length,
                itemBuilder: (_, int index) {
                  final item = state.items[index];

                  return ListTile(
                      tileColor: Colors.white,
                      onTap: () => controller.selectItem(item),
                      title: Text(item.title));
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            constraints: _kListBoxConstraints,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.selectedItems.length,
                itemBuilder: (_, int index) {
                  final item = state.selectedItems[index];

                  return ListTile(
                      tileColor: Colors.white,
                      onTap: () => controller.removeItem(item),
                      title: Text(item.title));
                }),
          ),
        ],
      );
    });
  }
}

const _kListBoxConstraints = BoxConstraints(
  maxWidth: 300,
  maxHeight: 200,
);
