import 'package:hive/hive.dart';

part 'offline_payment_model.g.dart';

@HiveType(typeId: 11)
class OfflinePaymentModel extends HiveObject {
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

  OfflinePaymentModel({
    required this.id,
    required this.tenantId,
    required this.amount,
    required this.date,
    required this.month,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflinePaymentModel &&
          other.id == id &&
          other.tenantId == tenantId &&
          other.amount == amount &&
          other.date == date &&
          other.month == month;

  @override
  int get hashCode =>
      id.hashCode ^
      tenantId.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      month.hashCode;
}
