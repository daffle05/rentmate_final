// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_tenant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineTenantModelAdapter extends TypeAdapter<OfflineTenantModel> {
  @override
  final int typeId = 10;

  @override
  OfflineTenantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineTenantModel(
      id: fields[0] as String,
      name: fields[1] as String,
      room: fields[2] as String,
      rentAmount: fields[3] as double,
      dueDate: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineTenantModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.room)
      ..writeByte(3)
      ..write(obj.rentAmount)
      ..writeByte(4)
      ..write(obj.dueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineTenantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
