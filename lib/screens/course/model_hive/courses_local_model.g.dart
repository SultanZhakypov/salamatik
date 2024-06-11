// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoursesLocalModelAdapter extends TypeAdapter<CoursesLocalModel> {
  @override
  final int typeId = 0;

  @override
  CoursesLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoursesLocalModel(
      image: fields[0] as String?,
      title: fields[1] as String?,
      video: fields[2] as String?,
      description: fields[3] as String?,
      tests: (fields[4] as List?)?.cast<TestsHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, CoursesLocalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.video)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.tests);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursesLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TestsHiveAdapter extends TypeAdapter<TestsHive> {
  @override
  final int typeId = 1;

  @override
  TestsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestsHive(
      available: fields[0] as int?,
      question: fields[1] as String?,
      variants: (fields[2] as List?)?.cast<VariantsHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, TestsHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.available)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.variants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariantsHiveAdapter extends TypeAdapter<VariantsHive> {
  @override
  final int typeId = 2;

  @override
  VariantsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VariantsHive(
      code: fields[0] as int?,
      variant: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VariantsHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.variant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
