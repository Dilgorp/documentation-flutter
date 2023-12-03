import 'package:documentation/model/category/category.dart';

class CategoryViewTree {
  final List<CategoryView> root = [];
  List<CategoryView> bottomLevel = [];

  final List<Category> byCategories = [];

  void addViews(Category category, List<CategoryView> views) {
    byCategories.add(category);

    if (root.isEmpty) {
      root.addAll(views);
      bottomLevel = root;
    } else {
      final newBottomLevel = <CategoryView>[];
      for (var view in bottomLevel) {
        view.children.addAll(
          views.map((e) => e.copy(view)),
        );
        newBottomLevel.addAll(view.children);
      }
      bottomLevel = newBottomLevel;
    }
  }
}

class CategoryView {
  final CategoryView? parent;
  final Category category;
  final String value;
  final String allValues;
  final List<CategoryView> children;

  CategoryView({
    required this.parent,
    required this.category,
    required this.value,
    required this.allValues,
    required this.children,
  });

  CategoryView copy(CategoryView? parent) => CategoryView(
        parent: parent?.copy(parent.parent),
        category: category.copy(),
        value: value,
        allValues: '${parent?.allValues ?? ''}$value',
        children: <CategoryView>[],
      );
}
