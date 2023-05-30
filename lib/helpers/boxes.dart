import 'package:hive/hive.dart';
import 'package:transactions_hive/models/transaction.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
