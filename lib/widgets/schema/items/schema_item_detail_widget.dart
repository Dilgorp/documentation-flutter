import 'package:documentation/model/schema_item.dart';
import 'package:flutter/material.dart';

class SchemaItemDetailWidget extends StatelessWidget {
  final SchemaItem schemaItem;
  final Function() onClose;

  const SchemaItemDetailWidget({
    super.key,
    required this.schemaItem,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Row(
                children: [
                  IconButton(
                    style: const ButtonStyle(
                      shape:
                          MaterialStatePropertyAll(ContinuousRectangleBorder()),
                    ),
                    onPressed: onClose,
                    icon: const Icon(Icons.double_arrow),
                  ),
                ],
              ),
              const Divider(),
              Text(
                schemaItem.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Visibility(
                visible: schemaItem.description.isNotEmpty,
                child: Column(
                  children: [
                    Text(
                      schemaItem.description,
                      textAlign: TextAlign.start,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ] +
            schemaItem.categories
                .map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${category.title}: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: category.name),
                      ]),
                    ),
                  ),
                )
                .toList() +
            [
              const Divider(),
            ] +
            schemaItem.properties
                .map(
                  (property) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${property.title}: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: property.value),
                      ]),
                    ),
                  ),
                )
                .toList() +
            [
              const Divider(),
            ],
      ),
    );
  }
}
