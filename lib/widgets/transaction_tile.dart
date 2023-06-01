import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  // Make it so that the constructor is a Transaction, instead of using its individual components
  final Transaction transaction;

  TransactionTile({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      elevation: 2,
      child: ExpansionTile(
        //contentPadding: const EdgeInsets.all(2),
        title: Text(
          transaction.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(transaction.createdDate.toString()),
        trailing: Text(
          '\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
              color: transaction.isExpense ? Colors.red : Colors.green),
        ),
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: null, child: Text('Edit')),
              TextButton(onPressed: null, child: Text('Delete'))
            ],
          )
        ],
      ),
    );
  }
}
