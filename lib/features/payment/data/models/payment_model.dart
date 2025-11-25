import 'package:hive/hive.dart';

part 'payment_model.g.dart';

@HiveType(typeId: 1)
class PaymentModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String tenantId;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String month;

  @HiveField(5)
  bool isPaid;

  PaymentModel({
    required this.id,
    required this.tenantId,
    required this.amount,
    required this.date,
    required this.month,
    this.isPaid = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          tenantId == other.tenantId &&
          amount == other.amount &&
          date == other.date &&
          month == other.month;

  @override
  int get hashCode =>
      id.hashCode ^ tenantId.hashCode ^ amount.hashCode ^ date.hashCode ^ month.hashCode;

  DateTime get dueDate => date;
}
