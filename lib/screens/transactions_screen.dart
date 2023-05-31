import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
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
        title: const Text('Hive Expense Tracket'),
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
          final list = box.values.toList().cast<Transaction>();

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final DateTime date = list[index].createdDate;
                final DateFormat formatter = DateFormat.yMMMMd();
                final String formatted = formatter.format(date);

                return TransactionTile(
                  title: list[index].name,
                  amount: list[index].amount,
                  date: formatted,
                );
              });
        },
      ),
    );
  }
}
