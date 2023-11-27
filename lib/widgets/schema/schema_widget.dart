import 'package:documentation/constants/colors.dart';
import 'package:documentation/constants/strings.dart';
import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/schema/schema_controller.dart';
import 'package:documentation/extensions/list_extensions.dart';
import 'package:documentation/model/schema_item.dart';
import 'package:documentation/model/schema_item_category.dart';
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
    Map<SchemaItemCategory?, List<SchemaItem>> itemsMap,
    List<SchemaItemCategory?> keys,
  ) {
    final List<Widget> result = [];
    for (SchemaItemCategory? key in keys) {
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
    Map<SchemaItemCategory?, List<SchemaItem>> itemsMap,
    List<SchemaItemCategory?> keys,
  ) {
    final List<Widget> result = [];

    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];
      result.add(
        SchemaTitleWidget(
          title: key?.name ?? kMissing,
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
        (item) => item.categories
            .where((element) => element.title == state.category)
            .firstOrNull,
      );

      final List<SchemaItemCategory?> keys = itemsMap.keys.toList();
      keys.sort(schemaCategoryItemComparator);

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
