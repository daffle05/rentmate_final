import 'package:hive/hive.dart';

part 'tenant_model.g.dart';

@HiveType(typeId: 0)
class TenantModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String roomNumber;

  @HiveField(3)
  final double rentAmount;

  @HiveField(4)
  final DateTime dueDate;

  TenantModel({
    required this.id,
    required this.name,
    required this.roomNumber,
    required this.rentAmount,
    required this.dueDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TenantModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          roomNumber == other.roomNumber &&
          rentAmount == other.rentAmount &&
          dueDate == other.dueDate;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ roomNumber.hashCode ^ rentAmount.hashCode ^ dueDate.hashCode;
}
