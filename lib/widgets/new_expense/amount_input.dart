import 'package:flutter/material.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '₱',
        label: Text("Amount"),
      ),
    );
  }
}
