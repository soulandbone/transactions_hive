import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime createdDate;

  @HiveField(2)
  bool isExpense;

  @HiveField(3)
  double amount;

  Transaction(
      {required this.name,
      required this.createdDate,
      this.isExpense = true,
      required this.amount});
}
