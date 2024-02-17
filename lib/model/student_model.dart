import 'package:hive/hive.dart';
part 'student_model.g.dart';
@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String photo;

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;
  
  @HiveField(4)
  String mobile;
  
  @HiveField(5)
  String gender;

  @HiveField(6)
  String domain;

  @HiveField(7)
  String dob;

  StudentModel(
      {this.id,
      required this.photo,
      required this.name,
      required this.gender,
      required this.domain,
      required this.mobile,
      required this.email,
      required this.dob});
}
