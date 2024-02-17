import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_log__provider/model/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentdb = await Hive.openBox<StudentModel>("student_db");
  final id = await studentdb.add(value);
  final data = studentdb.get(id);

  await studentdb.put(
      id,
      StudentModel(
          id: id,
          photo: data!.photo,
          name: data.name,
          gender: data.gender,
          domain: data.domain,
          mobile: data.mobile,
          email: data.email,
          dob: data.dob));
}

Future<void> getStudents() async {
  final studentdb = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentdb.values);
  studentListNotifier.value.sort(
    (a, b) => a.name.compareTo(b.name),
  );
  studentListNotifier.notifyListeners();
}

Future<int> studentCount() async {
  final studentdb = await Hive.openBox<StudentModel>("student_db");
  return studentdb.length;
}

Future<void> deleteStudent(int id) async {
  final studentdb = await Hive.openBox<StudentModel>("student_db");
  await studentdb.delete(id);
  getStudents();
}

Future<void> editStudent(
    int id,
    String updatedPhoto,
    String updatedName,
    String updatedGender,
    String updatedDomain,
    String updatedDob,
    String updatedMobile,
    String updatedEmail) async {
  final studentdb = await Hive.openBox<StudentModel>('student_db');
  final existingStudent = studentdb.values.firstWhere((s) => s.id == id);
  if (existingStudent == null) {
    print("Student not found");
  } else {
    existingStudent.photo = updatedPhoto;
    existingStudent.name = updatedName;
    existingStudent.gender = updatedGender;
    existingStudent.domain = updatedDomain;
    existingStudent.dob = updatedDob;
    existingStudent.mobile = updatedMobile;
    existingStudent.email = updatedEmail;

    await studentdb.put(id, existingStudent);
    getStudents();
  }
}