import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/transaction.dart';

class NetExpenseWidget extends StatelessWidget {
  final List<Transaction> transactionList;

  NetExpenseWidget({
    required this.transactionList,
  });

  @override
  Widget build(BuildContext context) {
    final amount = calculateNetAmount();
    print('Amount is $amount');
    return Column(
      children: [
        const Gap(15),
        const Text(
          'Net Expense',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
        Text(
          amount < 0
              ? '\$${amount.toStringAsFixed(2).substring(1)}'
              : '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 24, color: amount < 0 ? Colors.red : Colors.green),
        )
      ],
    );
  }

  double calculateNetAmount() {
    final expenseList = transactionList.where((element) {
      return element.isExpense == true;
    }).toList();
    final incomeList = transactionList.where((element) {
      return element.isExpense == false;
    }).toList();

    double incomeAmount = incomeList.fold(
        0, (previousValue, element) => previousValue + element.amount);
    double expenseAmount = expenseList.fold(
        0, (previousValue, element) => previousValue + element.amount);

    print('income amount is $incomeAmount');
    print('incomeList is $incomeList');
    print('transaction list is ${transactionList[0].amount}');
    return (incomeAmount - expenseAmount);
  }
}
