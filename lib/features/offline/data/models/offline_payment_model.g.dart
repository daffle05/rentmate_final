// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_payment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflinePaymentModelAdapter extends TypeAdapter<OfflinePaymentModel> {
  @override
  final int typeId = 11;

  @override
  OfflinePaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflinePaymentModel(
      id: fields[0] as String,
      tenantId: fields[1] as String,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
      month: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OfflinePaymentModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.month);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflinePaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
