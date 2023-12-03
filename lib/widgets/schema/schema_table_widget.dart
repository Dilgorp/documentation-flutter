import 'package:documentation/constants/colors.dart';
import 'package:documentation/constants/widgets.dart';
import 'package:documentation/controllers/schema/schema_table_controller.dart';
import 'package:documentation/model/category/category.dart';
import 'package:documentation/model/category/view/category_view.dart';
import 'package:documentation/model/schema/schema.dart';
import 'package:documentation/model/schema/schema_item.dart';
import 'package:documentation/widgets/schema/items/schema_item_widget.dart';
import 'package:documentation/widgets/schema/schema_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchemaTableWidget extends GetView<SchemaTableScreenController> {
  const SchemaTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) return kNoContentWidget;

      final categoryViewTree = _buildCategoryViewTree(state);

      final List<Widget> table = [];
      table.addAll(_tableHead(categoryViewTree));
      table.addAll(_tableBody(categoryViewTree, state.schema));

      return Container(
        width: 4000,
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.all(categoryViewTree.byCategories.isEmpty ? 0.0 : 8.0),
          child: Column(
            children: table,
          ),
        ),
      );
    });
  }

  CategoryViewTree _buildCategoryViewTree(SchemaTableScreenState state) {
    final tree = CategoryViewTree();

    for (int i = 0; i < state.selectedCategories.length; i++) {
      final category = state.selectedCategories[i];
      final values = state.categoryValues[category] ?? [];
      final categoryViews = _categoryViews(category, values);

      tree.addViews(category, categoryViews);
    }

    return tree;
  }

  List<CategoryView> _categoryViews(
    Category category,
    List<String> values,
  ) =>
      values
          .map(
            (e) => CategoryView(
              parent: null,
              category: category,
              value: e,
              allValues: e,
              children: <CategoryView>[],
            ),
          )
          .toList();

  List<Widget> _tableHead(CategoryViewTree categoryViewTree) {
    final List<Widget> result = [];
    _fillTableHeadRow(result, categoryViewTree.root);
    return result;
  }

  void _fillTableHeadRow(List<Widget> widgets, List<CategoryView> views) {
    if (views.isEmpty) return;

    final nextRowViews = <CategoryView>[];
    final listForRow = <Widget>[];

    for (int i = 0; i < views.length; i++) {
      final view = views[i];

      listForRow.addAll(<Widget>[
        Expanded(
          flex: 1,
          child: SchemaTitleWidget(
            title: view.value,
            itemsCount: 0,
            color: kSchemaTitleColors[i % 12],
            showItemCount: false,
          ),
        ),
      ]);
      nextRowViews.addAll(view.children);
    }

    widgets.add(
      SizedBox(
        child: Row(
          children: listForRow,
        ),
      ),
    );

    _fillTableHeadRow(widgets, nextRowViews);
  }

  List<Widget> _tableBody(CategoryViewTree categoryViewTree, Schema schema) {
    final Map<String, List<SchemaItem>> columns = {};
    for (var view in categoryViewTree.bottomLevel) {
      columns[view.allValues] = <SchemaItem>[];
    }

    for (var item in schema.items) {
      columns[item.categoryValues(categoryViewTree.byCategories)]?.add(item);
    }

    final rowColumns = <Widget>[];
    for (var view in categoryViewTree.bottomLevel) {
      final children = <Widget>[];

      final items = columns[view.allValues];
      if (items == null) {
        rowColumns.add(Expanded(flex: 1, child: Column(children: children)));
        continue;
      }

      children.addAll(
        items.map((e) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: SchemaItemWidget(
                selected: false,
                schemaItem: e,
                maxWidthEnabled: false,
              ),
            )),
      );

      rowColumns.add(Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      ));
    }

    // int rows = 0;
    // for (var list in columns.values) {
    //   rows = max(list.length, rows);
    // }

    // final List<Widget> widgets = [];
    // for (int i = 0; i < rows; i++) {
    //   final listForRow = <Widget>[];
    //
    //   for (var view in categoryViewTree.bottomLevel) {
    //     final items = columns[view.allValues];
    //     if (items == null) continue;
    //
    //     final Widget child;
    //     if (items.length <= i) {
    //       child = Container();
    //     } else {
    //       child = Padding(
    //         padding: const EdgeInsets.all(4.0),
    //         child: SchemaItemWidget(
    //           selected: false,
    //           schemaItem: items[i],
    //         ),
    //       );
    //     }
    //
    //     listForRow.addAll(<Widget>[
    //       Expanded(
    //         flex: 1,
    //         child: child,
    //       ),
    //     ]);
    //   }
    //
    //   widgets.add(
    //     SizedBox(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: listForRow,
    //       ),
    //     ),
    //   );
    // }

    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowColumns,
      )
    ];
  }
}
