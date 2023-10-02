import 'package:documentation/constants/colors.dart';
import 'package:documentation/constants/strings.dart';
import 'package:documentation/data/mock_schema_item.dart';
import 'package:documentation/extensions/schema_item_list_extensions.dart';
import 'package:documentation/model/schema_item.dart';
import 'package:documentation/widgets/common/drop_down_menu.dart';
import 'package:documentation/widgets/schema/items/schema_item_detail_widget.dart';
import 'package:documentation/widgets/schema/schema_widget.dart';
import 'package:flutter/material.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key});

  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  SchemaItem? _schemaItem;
  final _categoriesSet = kSchemaItems.categoriesSet;
  String _category = kController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
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
                    child: PanelDropdownMenu(
                      items: _categoriesSet,
                      onSelected: (String? value) {
                        if (value == null) return;
                        setState(() {
                          _category = value;
                        });
                      },
                      initialItem: kController,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 80,
                    child: SchemaWidget(
                      selectedItem: _schemaItem,
                      items: kSchemaItems,
                      category: _category,
                      onItemTap: (SchemaItem schemaItem) {
                        if (_schemaItem == schemaItem) return;
                        setState(() {
                          _schemaItem = schemaItem;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: _schemaItem != null,
                    child: Expanded(
                      flex: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 0.0),
                          color: Colors.white,
                        ),
                        child: _schemaItem == null
                            ? Container()
                            : SchemaItemDetailWidget(
                                schemaItem: _schemaItem!,
                                onClose: () {
                                  setState(() {
                                    _schemaItem = null;
                                  });
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
