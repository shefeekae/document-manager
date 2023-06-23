// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileModelAdapter extends TypeAdapter<FileModel> {
  @override
  final int typeId = 0;

  @override
  FileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileModel(
      title: fields[0] as String,
      description: fields[1] as String,
      path: fields[2] as String,
      size: fields[3] as String,
      documentType: fields[4] as String,
      modifiedDate: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.documentType)
      ..writeByte(5)
      ..write(obj.modifiedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
