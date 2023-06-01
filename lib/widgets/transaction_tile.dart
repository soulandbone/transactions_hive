import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  // Make it so that the constructor is a Transaction, instead of using its individual components
  final Transaction transaction;

  TransactionTile({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime date = transaction.createdDate;
    final DateFormat formatter = DateFormat.yMMMMd();
    final String formatedDate = formatter.format(date);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      elevation: 2,
      child: ExpansionTile(
        //contentPadding: const EdgeInsets.all(2),
        title: Text(
          transaction.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(formatedDate),
        trailing: Text(
          '\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
              color: transaction.isExpense ? Colors.red : Colors.green),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: null, child: Text('Edit')),
              TextButton(onPressed: deleteTrx, child: const Text('Delete'))
            ],
          )
        ],
      ),
    );
  }

  void deleteTrx() {
    transaction.delete();
  }
}
