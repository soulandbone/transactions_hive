import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:transactions_hive/helpers/boxes.dart';

import '../models/transaction.dart';

class TransactionDialog extends StatefulWidget {
  final Transaction? transaction;
  TransactionDialog({
    this.transaction,
  });

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  @override
  void initState() {
    if (widget.transaction != null) {
      isEdit = true;
      nameController.text = widget.transaction!.name;
      amountController.text = widget.transaction!.amount.toStringAsFixed(2);
    }
    super.initState();
  }

  bool isEdit = false;
  bool isExpense = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  isEdit ? 'Edit Transaction' : 'Add Transaction',
                ),
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return 'Please submit a valid name for the transaction';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.black54)),
                    hintText: 'Enter Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.black54))),
              ),
              const Gap(10),
              TextFormField(
                controller: amountController,
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
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.black54)),
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
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              final validated = _formKey.currentState!.validate();
              if (validated) {
                isEdit
                    ? editTransaction(widget.transaction!, nameController.text,
                        isExpense, double.parse(amountController.text))
                    : addTransaction(nameController.text, isExpense,
                        double.parse(amountController.text));
              }
            },
            child: Text(isEdit ? 'Edit' : 'Add'))
      ],
    );
  }

  void addTransaction(String name, bool isExpense, double amount) {
    final transaction = Transaction(
        name: name,
        createdDate: DateTime.now(),
        amount: amount, // amount: isExpense ? -amount : amount,
        isExpense: isExpense);

    var box = Boxes.getTransactions();
    box.add(transaction);
    Navigator.of(context).pop();
    // print(
    //     "The values of the box are ${box.values.toList().cast<Transaction>()[3].name}");
  }

  void editTransaction(
      Transaction transaction, String name, bool isExpense, double amount) {
    transaction.name = name;
    transaction.amount = amount;
    transaction.isExpense = isExpense;

    transaction.save();
    Navigator.of(context).pop();
    // print(
    //     "The values of the box are ${box.values.toList().cast<Transaction>()[3].name}");
  }
}
