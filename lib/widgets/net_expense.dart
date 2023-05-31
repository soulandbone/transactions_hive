import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NetExpenseWidget extends StatelessWidget {
  final double amount;

  NetExpenseWidget({
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(15),
        const Text(
          'Net Expense',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 24, color: amount < 0 ? Colors.red : Colors.green),
        )
      ],
    );
  }
}
