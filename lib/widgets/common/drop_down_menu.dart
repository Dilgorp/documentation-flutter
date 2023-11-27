import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/common/select_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelDropdownMenu extends StatelessWidget {
  final String tag;
  final Rx<SelectListController<String>?> controller = Rx(null);

  PanelDropdownMenu({
    super.key,
    required this.tag,
  }) {
    controller.value = Get.find<SelectListController<String>>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value == null) return kNoContentWidget;

    return controller.value!.obx((state) {
      if (state == null) return kNoContentWidget;

      return DropdownMenu<String>(
        enableSearch: false,
        inputDecorationTheme: const InputDecorationTheme(
          outlineBorder: BorderSide.none,
          border: InputBorder.none,
        ),
        initialSelection: state.items.first,
        onSelected: (value) {
          controller.value!.selectItem(value);
        },
        dropdownMenuEntries:
            state.items.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      );
    });
  }
}
