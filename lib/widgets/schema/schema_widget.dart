import 'package:documentation/constants/colors.dart';
import 'package:documentation/constants/strings.dart';
import 'package:documentation/extensions/list_extensions.dart';
import 'package:documentation/model/schema_item.dart';
import 'package:documentation/model/schema_item_category.dart';
import 'package:documentation/widgets/schema/items/schema_item_widget.dart';
import 'package:documentation/widgets/schema/schema_title_widget.dart';
import 'package:flutter/material.dart';

class SchemaWidget extends StatelessWidget {
  final List<SchemaItem> items;
  final String category;
  final Function(SchemaItem schemaItem) onItemTap;
  final SchemaItem? selectedItem;

  const SchemaWidget({
    super.key,
    required this.items,
    required this.category,
    required this.onItemTap,
    required this.selectedItem,
  });

  List<Widget> _buildSchema(
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
                        selected: selectedItem == e,
                        schemaItem: e,
                        onItemTap: () {
                          onItemTap(e);
                        },
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
    final itemsMap = items.groupBy(
      (item) => item.categories
          .where((element) => element.title == category)
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
                  children: _buildSchema(itemsMap, keys),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
