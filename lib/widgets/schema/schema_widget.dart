import 'package:documentation/constants/colors.dart';
import 'package:documentation/constants/strings.dart';
import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/schema/schema_controller.dart';
import 'package:documentation/extensions/list_extensions.dart';
import 'package:documentation/model/category/view/item_category.dart';
import 'package:documentation/model/schema/schema_item.dart';
import 'package:documentation/widgets/schema/items/schema_item_widget.dart';
import 'package:documentation/widgets/schema/schema_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchemaWidget extends GetView<SchemaController> {
  const SchemaWidget({
    super.key,
  });

  List<Widget> _buildSchema(
    SchemaScreenState state,
    Map<ItemCategory?, List<SchemaItem>> itemsMap,
    List<ItemCategory?> keys,
  ) {
    final List<Widget> result = [];
    for (ItemCategory? key in keys) {
      result.add(
        Column(
          children: itemsMap[key]
                  ?.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: SchemaItemWidget(
                        selected: state.schemaItem == e,
                        schemaItem: e,
                      ),
                    ),
                  )
                  .toList() ??
              [],
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTitles(
    Map<ItemCategory?, List<SchemaItem>> itemsMap,
    List<ItemCategory?> keys,
  ) {
    final List<Widget> result = [];

    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];
      result.add(
        SchemaTitleWidget(
          title: key?.value ?? kMissing,
          itemsCount: itemsMap[key]?.length ?? 0,
          color: kSchemaTitleColors[i % 12],
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return kNoContentWidget;

      final itemsMap = state.schema.items.groupBy(
        (item) {
          final category = item.item.categories
              .where((element) => element.category.title == state.category)
              .firstOrNull;
          return category == null
              ? null
              : ItemCategory(
                  title: category.category.title,
                  value: category.value,
                );
        },
      );

      final List<ItemCategory?> keys = itemsMap.keys.toList();
      keys.sort(itemCategoryComparator);

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: _buildTitles(itemsMap, keys),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildSchema(state, itemsMap, keys),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
