import 'package:hive/hive.dart';

part 'offline_tenant_model.g.dart';

@HiveType(typeId: 10)
class OfflineTenantModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String room;

  @HiveField(3)
  final double rentAmount;

  @HiveField(4)
  final int dueDate;

  OfflineTenantModel({
    required this.id,
    required this.name,
    required this.room,
    required this.rentAmount,
    required this.dueDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineTenantModel &&
          other.id == id &&
          other.name == name &&
          other.room == room &&
          other.rentAmount == rentAmount &&
          other.dueDate == dueDate;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      room.hashCode ^
      rentAmount.hashCode ^
      dueDate.hashCode;
}
