import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String photo;

  @HiveField(2)
  String name;

  @HiveField(3)
  String gender;

  @HiveField(4)
  String domain;

  @HiveField(5)
  String mobile;

  @HiveField(6)
  String email;

  StudentModel(
      {this.id,
      required this.photo,
      required this.name,
      required this.gender,
      required this.domain,
      required this.mobile,
      required this.email});
}
