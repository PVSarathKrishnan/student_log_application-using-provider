// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_log__provider/model/database_functions.dart';
import 'package:student_log__provider/model/student_model.dart';
import 'package:student_log__provider/services/student_helper.dart';
import 'package:student_log__provider/views/screens/home_page.dart';
import 'package:student_log__provider/views/styles/text_theme.dart';
import 'package:student_log__provider/views/styles/theme_colours.dart';
import 'package:student_log__provider/services/validators.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({super.key, required this.isedit, this.stu});
  bool isedit = false;
  StudentModel? stu;
  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final gender = ["male", "female", "Others"];
  String selGender = "";
  final domainList = [
    'MERN',
    'MEAN',
    'Django and React',
    'Flutter',
    'Data Science',
    'Cyber security',
    "GoLang",
    "Java",
    "Unity Game Development",
    "DevOps"
  ];
  String selDomain = "";
  File? _selectedImage;
  DateTime dob = DateTime.now();
  String? d;
  DateTime? db;
  @override
  Widget build(BuildContext context) {
    if (widget.isedit) {
      _selectedImage = File(widget.stu!.photo);
      _nameController.text = widget.stu!.name;
      selGender = widget.stu!.gender;
      selDomain = widget.stu!.domain;
      db = DateTime.parse(widget.stu!.dob);
      _mobileController.text = widget.stu!.mobile;
      _emailController.text = widget.stu!.email;
    }
    return Consumer<StudentProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Add student information",
            style: text_bold(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedImage = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedImage != null) {
                                _selectedImage = File(pickedImage.path);
                                value.getImage(_selectedImage!);
                              }
                            },
                            child: Container(
                                height: 120,
                                width: 120,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: purpleTheme(),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(width: 1)),
                                child: _selectedImage != null
                                    ? Image.file(
                                        _selectedImage!,
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.fill,
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo_rounded,
                                          ),
                                          Text("Add a photo")
                                        ],
                                      )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autocorrect: true,
                            controller: _nameController,
                            validator: Validators.validateFullName,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: "Student Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autocorrect: true,
                            validator: Validators.validateEmail,
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autocorrect: true,
                            controller: _mobileController,
                            validator: Validators.validateMobile,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: "Mobile",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(22)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Gender : "),
                                ),
                                Row(
                                  children: gender.map((String value1) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(value1),
                                          Radio(
                                            value: value1,
                                            groupValue: selGender,
                                            onChanged: (Selectedvalue) {
                                              selGender =
                                                  Selectedvalue.toString();
                                              value.getGender(selGender);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(), // Convert the Iterable<Container> to List<Widget>
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return "Select a domain";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Domain',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(22)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.0))),
                            items: domainList.map((String domain) {
                              return DropdownMenuItem(
                                child: Text(domain),
                                value: domain,
                              );
                            }).toList(),
                            onChanged: (String? domain) {
                              value.getDomain(domain!);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Choose Date of Birth : "),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: dob,
                                              firstDate: DateTime(1990),
                                              lastDate: DateTime(2025));
                                      if (pickedDate != null &&
                                          pickedDate != dob) {
                                        dob = pickedDate;
                                        value.getDOB(dob);
                                      }
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_month),
                                          Text(
                                            DateFormat(
                                              'dd-MM-yyyy',
                                            ).format(DateTime.parse("$dob")),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            child: ElevatedButton(
                                onPressed: () {
                                  submit(
                                      d = value.domain, db = value.dateOfBirth);
                                },
                                child: Text(
                                  "Submit",
                                  style: text_bold(),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit(String? d, DateTime? db) async {
    final imagePath = _selectedImage?.path;
    final name = _nameController.text.trim();
    final gender = selGender;
    final domain = d;
    final dob = db?.toString();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      if (imagePath != null && dob != null) {
        final student = StudentModel(
            photo: imagePath,
            name: name,
            gender: gender,
            domain: domain!,
            mobile: mobile,
            email: email,
            dob: dob);

        addStudent(student);
        Navigator.pushAndRemoveUntil(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
          content: Text("Enter All Data"),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

//to update
  Future<void> edit(String? d, DateTime? db) async {
    int? id = widget.stu!.id;
    final imagePath = _selectedImage?.path;
    final name = _nameController.text.trim();
    final gender = selGender;
    final domain = d;
    final dob = db?.toString();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      if (imagePath != null && dob != null && gender != null) {
        editStudent(id!, imagePath, name, gender, domain!, dob, mobile, email);
      } else {
        // Handle the case where imagePath, dob, or gender is null
        // print("Error: imagePath, dob, or gender is null");
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text('Enter all data'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text('Enter all data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
