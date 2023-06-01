import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class CategoryInput extends StatelessWidget {
  const CategoryInput({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final Category selectedCategory;
  final void Function(Category value) onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        onCategoryChanged(value);
      },
    );
  }
}
