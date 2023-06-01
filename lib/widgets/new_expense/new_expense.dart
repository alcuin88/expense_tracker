import 'package:expense_tracker/widgets/new_expense/amount_input.dart';
import 'package:expense_tracker/widgets/new_expense/category_input.dart';
import 'package:expense_tracker/widgets/new_expense/date_input.dart';
import 'package:expense_tracker/widgets/new_expense/title_input.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _onCategoryChanged(value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input!"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered."),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Okay")),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraint) {
      final width = constraint.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TitleInput(titleController: _titleController)),
                      const SizedBox(
                        height: 24
                      ),
                      Expanded(
                        child: AmountInput(amountController: _amountController),
                      ),
                    ],
                  )
                else
                  TitleInput(titleController: _titleController),
                if (width >= 600)
                  Row(
                    children: [
                      CategoryInput(
                        selectedCategory: _selectedCategory,
                        onCategoryChanged: _onCategoryChanged,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      DateInput(
                        presentDatePicker: _presentDatePicker,
                        selectedDate: _selectedDate,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: AmountInput(amountController: _amountController),
                      ),
                      const SizedBox(width: 16),
                      DateInput(
                        presentDatePicker: _presentDatePicker,
                        selectedDate: _selectedDate,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text("Save Expense"),
                    ),
                  ])
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CategoryInput(
                        selectedCategory: _selectedCategory,
                        onCategoryChanged: _onCategoryChanged,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Save Expense"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
