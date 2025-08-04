// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 1;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      id: fields[0] as String,
      name: fields[1] as String,
      mainAccountId: fields[2] as int,
      category: fields[3] as String,
      totalAccountBalance: fields[4] as double,
      debtor: fields[5] as double,
      creditor: fields[6] as double,
      currencyCode: fields[7] as String?,
      createdAt: fields[8] as DateTime,
      phoneNumber: fields[11] as String?,
      note: fields[9] as String?,
      image: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.mainAccountId)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.totalAccountBalance)
      ..writeByte(5)
      ..write(obj.debtor)
      ..writeByte(6)
      ..write(obj.creditor)
      ..writeByte(7)
      ..write(obj.currencyCode)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.note)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
