import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transactions_hive/models/transaction.dart';
import 'package:transactions_hive/screens/transactions_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>(
      'transactions'); // Tutorial uses await Hive.openBox<Transaction>('transactions); but I dont think it is longer needed.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionsScreen(),
    );
  }
}
