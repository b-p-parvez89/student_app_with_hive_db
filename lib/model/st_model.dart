//import 'dart:io';

import 'package:hive/hive.dart';
part 'st_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String roll;
  @HiveField(3)
  String classes;
  @HiveField(4)
  String details;
  // @HiveField(5)
  // File image;

  StudentModel({
    required this.name,
    required this.roll,
    required this.classes,
    required this.age,
    required this.details,
    // required this.image
  });
}
