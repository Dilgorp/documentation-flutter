import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/schema/schema_current_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchemaItemDetailWidget extends GetView<SchemaCurrentItemController> {
  const SchemaItemDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return kNoContentWidget;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Row(
                  children: [
                    IconButton(
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder()),
                      ),
                      onPressed: () {
                        controller.changeSchemaItem(null);
                      },
                      icon: const Icon(Icons.double_arrow),
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  state.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Visibility(
                  visible: state.description?.isNotEmpty ?? false,
                  child: Column(
                    children: [
                      Text(
                        state.description ?? '',
                        textAlign: TextAlign.start,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ] +
              state.categories
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
              state.properties
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
    });
  }
}
