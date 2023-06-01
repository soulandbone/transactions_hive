import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:transactions_hive/widgets/net_expense.dart';
import 'package:transactions_hive/widgets/transaction_dialog.dart';
import 'package:transactions_hive/widgets/transaction_tile.dart';

import '../models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Expense Tracker'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => const TransactionDialog()),
          child: const Icon(Icons.add)),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box<Transaction>('transactions').listenable(),
        builder: (context, box, widget) {
          final transactionsList = box.values.toList().cast<Transaction>();

          return Column(
            children: [
              NetExpenseWidget(transactionList: transactionsList),
              const Gap(20),
              Expanded(
                  child: ListView.builder(
                      itemCount: transactionsList.length,
                      itemBuilder: (context, index) {
                        return TransactionTile(
                          transaction: transactionsList[index],
                        );
                      }))
            ],
          );
        },
      ),
    );
  }
}
