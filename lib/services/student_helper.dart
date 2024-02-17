import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_log__provider/model/student_model.dart';

class StudentProvider extends ChangeNotifier {
  File? profileImage;
  DateTime? dateOfBirth;
  String? gender;
  String? domain;

  List<StudentModel> _studentList = [];
  List<StudentModel> get studentList => _studentList;

  int count = 0;

  // adding image
  getImage(File image) {
    profileImage = image;
    notifyListeners();
  }

  //adding date of birth
  getDOB(DateTime dob) {
    dateOfBirth = dob;
    notifyListeners();
  }

  //to add gender
  getGender(String g) {
    gender = g;
    notifyListeners();
  }

  //to add domain
  getDomain(String d) {
    domain = d;
    notifyListeners();
  }

  //searching
  searchStudent(List<StudentModel> newList) {
    _studentList = newList;
    notifyListeners();
  }
}
