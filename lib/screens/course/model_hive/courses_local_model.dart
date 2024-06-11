// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

part 'courses_local_model.g.dart';

@HiveType(typeId: 0)
class CoursesLocalModel extends HiveObject {
  @HiveField(0)
  final String? image;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? video;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final List<TestsHive>? tests;

  CoursesLocalModel({
    required this.image,
    required this.title,
    required this.video,
    required this.description,
    required this.tests,
  });
}

@HiveType(typeId: 1)
class TestsHive extends HiveObject {
  @HiveField(0)
  final int? available;
  @HiveField(1)
  final String? question;
  @HiveField(2)
  final List<VariantsHive>? variants;

  TestsHive({
    required this.available,
    required this.question,
    required this.variants,
  });
}

@HiveType(typeId: 2)
class VariantsHive extends HiveObject {
  @HiveField(0)
  final int? code;
  @HiveField(1)
  final String? variant;

  VariantsHive({required this.code, required this.variant});
}


class NfcCardKeysHelper {
  NfcCardKeysHelper() {
    registerAdapter();
  }
  String boxNameAndKey = 'nfcCrdKeys';

  Future<void> setCardKeyInfo(List<CoursesLocalModel> keysList) async {
    final box = Hive.isBoxOpen(boxNameAndKey)
        ? Hive.box<CoursesLocalModel>(boxNameAndKey)
        : await Hive.openBox<CoursesLocalModel>(boxNameAndKey);
    box.addAll(keysList);
  }

  Future<List<CoursesLocalModel>> getCardKeys() async {
    final box = Hive.isBoxOpen(boxNameAndKey)
        ? Hive.box<CoursesLocalModel>(boxNameAndKey)
        : await Hive.openBox<CoursesLocalModel>(boxNameAndKey);
    return box.values.toList();
  }

  Future<void> clearCardKeys() async {
    final box = Hive.isBoxOpen(boxNameAndKey)
        ? Hive.box<CoursesLocalModel>(boxNameAndKey)
        : await Hive.openBox<CoursesLocalModel>(boxNameAndKey);
    await box.clear();
    await box.compact();
    await box.close();
  }

  Future<void> deleteById(int index) async {
    final box = Hive.isBoxOpen(boxNameAndKey)
        ? Hive.box<CoursesLocalModel>(boxNameAndKey)
        : await Hive.openBox<CoursesLocalModel>(boxNameAndKey);
    await box.deleteAt(index);
    await box.close();
  }

  void registerAdapter() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CoursesLocalModelAdapter());
    }
  }
}


// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'cources_model.freezed.dart';
// part 'cources_model.g.dart';

// @freezed
// class Courses with _$Courses {
//   const factory Courses({
//     String? image,
//     List<Tests>? tests,
//     String? title,
//     String? video,
//     String? description,
//   }) = _Courses;

//   factory Courses.fromJson(Map<String, dynamic> json) =>
//       _$CoursesFromJson(json);
// }

// @freezed
// class Tests with _$Tests {
//   const factory Tests({
//     int? available,
//     String? question,
//     List<Variants>? variants,
//   }) = _Tests;

//   factory Tests.fromJson(Map<String, dynamic> json) => _$TestsFromJson(json);
// }

// @freezed
// class Variants with _$Variants {
//   const factory Variants({
//     int? code,
//     String? variant,
//   }) = _Variants;

//   factory Variants.fromJson(Map<String, dynamic> json) =>
//       _$VariantsFromJson(json);
// }
