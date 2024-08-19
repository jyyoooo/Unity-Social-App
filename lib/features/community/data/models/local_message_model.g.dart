// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<LocalMessage> {
  @override
  final int typeId = 0;

  @override
  LocalMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalMessage(
      senderId: fields[0] as String,
      text: fields[1] as String,
      sentAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalMessage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.senderId)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.sentAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
