import 'package:documentation/constants/strings.dart';
import 'package:documentation/constants/text.dart';
import 'package:documentation/extensions/properties_extensions.dart';
import 'package:documentation/model/schema_item.dart';
import 'package:flutter/material.dart';

const _kBorderRadius = BorderRadius.all(Radius.circular(2));

class SchemaItemWidget extends StatelessWidget {
  final SchemaItem schemaItem;
  final Function() onItemTap;
  final bool selected;

  const SchemaItemWidget({
    super.key,
    required this.schemaItem,
    required this.onItemTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final description = schemaItem.description.isEmpty
        ? '$kReturns: ${schemaItem.properties.returns}'
        : schemaItem.description;

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300.0,
      ),
      decoration: const BoxDecoration(
        borderRadius: _kBorderRadius,
      ),
      child: Material(
        borderRadius: _kBorderRadius,
        color: selected ? Colors.black12 : Colors.white,
        child: InkWell(
          borderRadius: _kBorderRadius,
          onTap: () {
            onItemTap();
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
                      schemaItem.title,
                      style: kTitleStyle,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      description,
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
