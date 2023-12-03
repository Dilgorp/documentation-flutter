import 'package:documentation/constants/strings.dart';
import 'package:documentation/constants/text.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:documentation/extensions/properties_extensions.dart';
import 'package:documentation/model/schema/schema_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _kBorderRadius = BorderRadius.all(Radius.circular(2));

class SchemaItemWidget extends GetView<SchemaCurrentItemController> {
  final SchemaItem schemaItem;
  final bool selected;
  final bool maxWidthEnabled;

  const SchemaItemWidget({
    super.key,
    required this.schemaItem,
    required this.selected,
    this.maxWidthEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final description = (schemaItem.item.description?.isEmpty ?? false)
        ? '$kReturns: ${schemaItem.item.properties.returns}'
        : schemaItem.item.description;

    return Container(
      constraints: maxWidthEnabled
          ? const BoxConstraints(
              maxWidth: 300.0,
            )
          : const BoxConstraints(),
      decoration: const BoxDecoration(
        borderRadius: _kBorderRadius,
      ),
      child: Material(
        borderRadius: _kBorderRadius,
        color: selected ? Colors.black12 : Colors.white,
        child: InkWell(
          borderRadius: _kBorderRadius,
          onTap: () {
            controller.changeSchemaItem(schemaItem);
            Scaffold.of(context).openEndDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.0),
              borderRadius: _kBorderRadius,
              color: Colors.transparent,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schemaItem.item.title,
                      style: kTitleStyle,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      description ?? '',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
