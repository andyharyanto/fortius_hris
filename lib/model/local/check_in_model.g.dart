// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckInModelAdapter extends TypeAdapter<CheckInModel> {
  @override
  final int typeId = 0;

  @override
  CheckInModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckInModel(
      date: fields[0] as String?,
      userName: fields[1] as String?,
      companyId: fields[2] as String?,
      status: fields[3] as String?,
      durationInHrMin: fields[4] as String?,
      checkInTime: fields[5] as String?,
      checkInLatitude: fields[7] as double?,
      checkInLongitude: fields[8] as double?,
      checkInLocation: fields[6] as String?,
      checkOutTime: fields[9] as String?,
      checkOutLocation: fields[10] as String?,
      checkOutLatitude: fields[11] as double?,
      checkOutLongitude: fields[12] as double?,
      documentList: (fields[13] as List).cast<String>(),
      checkInPlaceMark: fields[14] as String?,
      checkOutPlaceMark: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CheckInModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.companyId)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.durationInHrMin)
      ..writeByte(5)
      ..write(obj.checkInTime)
      ..writeByte(6)
      ..write(obj.checkInLocation)
      ..writeByte(7)
      ..write(obj.checkInLatitude)
      ..writeByte(8)
      ..write(obj.checkInLongitude)
      ..writeByte(9)
      ..write(obj.checkOutTime)
      ..writeByte(10)
      ..write(obj.checkOutLocation)
      ..writeByte(11)
      ..write(obj.checkOutLatitude)
      ..writeByte(12)
      ..write(obj.checkOutLongitude)
      ..writeByte(13)
      ..write(obj.documentList)
      ..writeByte(14)
      ..write(obj.checkInPlaceMark)
      ..writeByte(15)
      ..write(obj.checkOutPlaceMark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckInModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
