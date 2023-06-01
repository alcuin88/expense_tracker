import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class DateInput extends StatelessWidget {
  const DateInput({
    super.key,
    required this.selectedDate,
    required this.presentDatePicker,
  });

  final DateTime? selectedDate;
  final void Function() presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedDate == null
              ? "Select date"
              : formatter.format(selectedDate!)),
          IconButton(
            onPressed: presentDatePicker,
            icon: const Icon(Icons.calendar_month),
          )
        ],
      ),
    );
  }
}
