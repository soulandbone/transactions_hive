import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transactions_hive/helpers/snackbar_helper.dart';

class TransactionDialog extends StatefulWidget {
  const TransactionDialog({super.key});

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  bool isExpense = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
          key: _formKey,
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
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return 'Please submit a valid name for the transaction';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.black54))),
              ),
              const Gap(10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an amount';
                  } else if (double.parse(value) <= 0) {
                    return 'Please enter an amount greater than zero';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Enter Amount',
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.black54))),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const TextButton(onPressed: null, child: Text('Cancel')),
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showSnackbarMessage(context, message: 'Validation is working');
              }
            },
            child: const Text('Add'))
      ],
    );
  }
}
