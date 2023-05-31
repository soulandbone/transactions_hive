import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final double amount;

  TransactionTile(
      {required this.title,
      required this.date,
      required this.amount,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        //contentPadding: const EdgeInsets.all(2),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text('\$${amount.toString()}'),
      ),
    );
  }
}
