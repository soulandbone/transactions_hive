import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TransactionDialog extends StatefulWidget {
  const TransactionDialog({super.key});

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
          child: SingleChildScrollView(
        child: Column(children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Add Transaction',
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter Name'),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter Amount'),
          ),
          const Gap(10),
          buildRadioOptions(),
          buildButtonRow()
        ]),
      )),
    );
  }
// **************************************** Widgets Components **************************************************

  Widget buildRadioOptions() => Column(
        children: [
          RadioListTile<bool>(
            title: const Text('Expense'),
            value: true,
            groupValue: isExpense,
            onChanged: (value) => setState(() {
              isExpense = value!;
            }),
          ),
          RadioListTile<bool>(
              title: const Text('Income'),
              value: false,
              groupValue: isExpense,
              onChanged: (value) => setState(() {
                    isExpense = value!;
                  }))
        ],
      );

  Widget buildButtonRow() {
    return const Row(
      children: [
        TextButton(onPressed: null, child: Text('Cancel')),
        TextButton(onPressed: null, child: Text('Add'))
      ],
    );
  }
}